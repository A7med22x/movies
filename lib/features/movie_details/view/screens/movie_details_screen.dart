import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/di/service_locator.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/widgets/error_indicator.dart';
import 'package:movies/core/widgets/loading_indicator.dart';
import 'package:movies/features/movie_details/view/widgets/custom_bar_section.dart';
import 'package:movies/features/movie_details/view/widgets/custom_cast_section.dart';
import 'package:movies/features/movie_details/view/widgets/custom_details_section.dart';
import 'package:movies/features/movie_details/view/widgets/custom_genres_section.dart';
import 'package:movies/features/movie_details/view/widgets/custom_screen_shots_section.dart';
import 'package:movies/features/movie_details/view/widgets/custom_similar_section.dart';
import 'package:movies/features/movie_details/view/widgets/custom_summary_section.dart';
import 'package:movies/features/movie_details/view_model/movie_details_states.dart';
import 'package:movies/features/movie_details/view_model/movie_details_view_model.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key, required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: ColorManager.background,
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (_) =>
              serviceLocator.get<MovieDetailsViewModel>()
                ..getMovieDetails(id: movieId),
          child: BlocBuilder<MovieDetailsViewModel, MovieDetailsState>(
            builder: (context, state) {
              if (state is GetMovieDetailsLoading) {
                return const SizedBox(height: 800, child: LoadingIndicator());
              } else if (state is GetMovieDetailsError) {
                return ErrorIndicator(state.errorMessage);
              } else if (state is GetMovieDetailsSuccess) {
                final movie = state.movie;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.9,
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: movie.largeCoverImage!,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  ColorManager.background.withValues(alpha: .2),
                                  ColorManager.background,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 24,
                            right: 0,
                            left: 0,
                            bottom: size.height * .12,
                            child: CustomDetailsSection(
                              movieURL: movie.url!,
                              year: '${movie.year}',
                              title: movie.title!,
                              movieId: movieId.toString(),
                            ),
                          ),
                          Positioned(
                            right: 16,
                            left: 16,
                            bottom: 16,
                            child: CustomBarSection(
                              rating: '${movie.rating}',
                              time: '${movie.runtime}',
                              like: '${movie.likeCount}',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomScreenShotsSection(
                            imagesURL: [
                              movie.largeScreenshotImage1 ??
                                  movie.mediumScreenshotImage1,
                              movie.largeScreenshotImage2 ??
                                  movie.mediumScreenshotImage2,
                              movie.largeScreenshotImage3 ??
                                  movie.mediumScreenshotImage3,
                            ],
                          ),
                          const SizedBox(height: 16),
                          CustomSimilarSection(movieId: movie.id),
                          const SizedBox(height: 16),
                          CustomSummarySection(
                            summary:
                                movie.descriptionFull ??
                                movie.summary ??
                                movie.descriptionIntro,
                          ),
                          const SizedBox(height: 16),
                          CustomCastSection(cast: movie.cast),
                          const SizedBox(height: 16),
                          CustomGenresSection(genres: movie.genres),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
