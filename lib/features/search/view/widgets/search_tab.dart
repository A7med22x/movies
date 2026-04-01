import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/models/movie.dart';
import 'package:movies/core/resources/assets_manager.dart';
import 'package:movies/core/widgets/custom_text_field.dart';
import 'package:movies/core/widgets/error_indicator.dart';
import 'package:movies/core/widgets/loading_indicator.dart';
import 'package:movies/core/widgets/movie_card.dart';
import 'package:movies/features/home/view_model/movies_states.dart';
import 'package:movies/features/home/view_model/movies_view_model.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  List<Movie> searchMovies = [];
  final _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  int totalMovies = 0;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          !isLoadingMore) {
        if (_searchController.text.isEmpty) return;
        if (searchMovies.length >= totalMovies) return;
        loadMoreMovies();
      }
    });
  }

  void searchForMovies(String query) {
    currentPage = 1;
    isLoadingMore = false;
    searchMovies.clear();
    context.read<MoviesViewModel>().getSearchMovies(
      page: currentPage,
      query: query,
    );
  }

  void loadMoreMovies() async {
    if (isLoadingMore) return;
    isLoadingMore = true;
    currentPage++;
    await context.read<MoviesViewModel>().getSearchMovies(
      query: _searchController.text,
      page: currentPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesViewModel, MoviesState>(
      builder: (context, state) {
        if (state is GetSearchMoviesSuccess) {
          totalMovies = state.movieCount;
          if (!isLoadingMore) {
            searchMovies = state.movies;
          } else {
            searchMovies.addAll(
              state.movies.where((m) => !searchMovies.any((e) => e.id == m.id)),
            );
          }
          isLoadingMore = false;
        }
        return Column(
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomTextField(
                hintText: 'Search',
                onFieldSubmitted: (query) {
                  searchForMovies(query);
                },
                controller: _searchController,
                prefixIconImageName: IconsAssets.search,
                suffixIconImageName: IconsAssets.delete,
                isSearch: true,
                onprefixIconTab: () {
                  if (_searchController.text.isEmpty) return;
                  searchForMovies(_searchController.text);
                },
                onsuffixIconTab: onClearInputFiled,
              ),
            ),
            Expanded(
              child: Builder(
                builder: (_) {
                  if (state is MoviesCleared) {
                    searchMovies.clear();
                    totalMovies = 0;
                    currentPage = 1;
                    isLoadingMore = false;
                  }
                  if (state is GetSearchMoviesLoading && searchMovies.isEmpty) {
                    return const LoadingIndicator();
                  } else if (state is GetSearchMoviesError) {
                    return ErrorIndicator(state.errorMessage);
                  } else if (searchMovies.isEmpty) {
                    return Center(
                      child: Image.asset(
                        ImageAssets.empty,
                        width: 124,
                        height: 124,
                        fit: BoxFit.fill,
                      ),
                    );
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
                        if (index < searchMovies.length) {
                          return MovieCard(movie: searchMovies[index]);
                        } else {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                      },
                      itemCount: searchMovies.length + (isLoadingMore ? 1 : 0),
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

  void onClearInputFiled() {
    _searchController.clear();
    context.read<MoviesViewModel>().clearMovies();
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
