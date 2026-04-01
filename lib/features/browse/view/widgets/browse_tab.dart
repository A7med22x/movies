import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/models/movie.dart';
import 'package:movies/core/widgets/error_indicator.dart';
import 'package:movies/core/widgets/loading_indicator.dart';
import 'package:movies/core/widgets/movie_card.dart';
import 'package:movies/features/browse/view/widgets/tab_item.dart';
import 'package:movies/features/home/data/models/movie_genres_model.dart';
import 'package:movies/features/home/view_model/movies_states.dart';
import 'package:movies/features/home/view_model/movies_view_model.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  List<Movie> movies = [];
  late int currentIndex;
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  int totalMovies = 0;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    getGenersMovies(MovieGenresModel.genres[currentIndex].name);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          !isLoadingMore) {
        if (movies.length >= totalMovies) return;
        loadMoreMovies();
      }
    });
  }

  void getGenersMovies(String genre) {
    currentPage = 1;
    isLoadingMore = false;
    movies.clear();
    context.read<MoviesViewModel>().getGenersMovies(
      page: currentPage,
      genres: (genre == 'All') ? '' : genre,
      sortBy: 'year',
    );
  }

  void loadMoreMovies() async {
    if (isLoadingMore) return;
    isLoadingMore = true;
    currentPage++;
    await context.read<MoviesViewModel>().getGenersMovies(
      page: currentPage,
      genres: (MovieGenresModel.genres[currentIndex].name == 'All')
          ? ''
          : MovieGenresModel.genres[currentIndex].name,
      sortBy: 'year',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesViewModel, MoviesState>(
      builder: (context, state) {
        if (state is GetGenersSuccess) {
          totalMovies = state.movieCount;
          if (!isLoadingMore) {
            movies = state.movies;
          } else {
            movies.addAll(
              state.movies.where((m) => !movies.any((e) => e.id == m.id)),
            );
          }
          isLoadingMore = false;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            DefaultTabController(
              length: MovieGenresModel.genres.length,
              child: TabBar(
                padding: const EdgeInsets.only(left: 16),
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                labelPadding: const EdgeInsets.only(right: 8),
                tabs: MovieGenresModel.genres
                    .map(
                      (tab) => TabItem(
                        tabName: tab.name,
                        isSelected:
                            currentIndex ==
                            MovieGenresModel.genres.indexOf(tab),
                      ),
                    )
                    .toList(),
                onTap: (index) {
                  if (currentIndex == index) return;
                  currentIndex = index;
                  getGenersMovies(MovieGenresModel.genres[currentIndex].name);
                  setState(() {});
                },
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Builder(
                builder: (_) {
                  if (state is GetGenersLoading && movies.isEmpty) {
                    return const LoadingIndicator();
                  } else if (state is GetGenersError) {
                    return ErrorIndicator(state.message);
                  } else {
                    return GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            childAspectRatio: 0.7,
                          ),
                      itemBuilder: (_, index) {
                        if (index < movies.length) {
                          return MovieCard(movie: movies[index]);
                        } else {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                      },
                      itemCount: movies.length + (isLoadingMore ? 1 : 0),
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
