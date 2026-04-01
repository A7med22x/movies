import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/resources/assets_manager.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/widgets/error_indicator.dart';
import 'package:movies/core/widgets/loading_indicator.dart';
import 'package:movies/core/widgets/movie_card.dart';
import 'package:movies/features/home/view_model/movies_states.dart';
import 'package:movies/features/home/view_model/movies_view_model.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({super.key});

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int currentIndex = 0;
  @override
  void initState() {
    context.read<MoviesViewModel>().getCarouselMovies(
      sortBy: 'year',
      minimumRating: 9,
      page: 1,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesViewModel, MoviesState>(
      builder: (context, state) {
        if (state is GetCarouselLoading) {
          return const LoadingIndicator();
        } else if (state is GetCarouselError) {
          return ErrorIndicator(state.message);
        } else if (state is GetCarouselSuccess) {
          final movies = state.movies;

          return Stack(
            children: [
              CachedNetworkImage(
                imageUrl: movies[currentIndex].largeCoverImage!,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorManager.background.withValues(alpha: .8),
                      ColorManager.background.withValues(alpha: .6),
                      ColorManager.background,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Image.asset(
                    ImageAssets.availableNow,
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    height: MediaQuery.sizeOf(context).height * 0.1,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: CarouselSlider(
                      items: movies
                          .map((movie) => MovieCard(movie: movie))
                          .toList(),
                      options: CarouselOptions(
                        height: MediaQuery.sizeOf(context).height * 0.7,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        enlargeFactor: .3,
                        viewportFraction: 0.65,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                  Image.asset(
                    ImageAssets.watchNow,
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    height: MediaQuery.sizeOf(context).height * 0.1,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
