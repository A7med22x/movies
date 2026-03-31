import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/di/service_locator.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/font_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';
import 'package:movies/core/widgets/error_indicator.dart';
import 'package:movies/core/widgets/loading_indicator.dart';
import 'package:movies/core/widgets/movie_card.dart';
import 'package:movies/features/movie_details/view_model/movie_details_states.dart';
import 'package:movies/features/movie_details/view_model/movie_details_view_model.dart';

class CustomSimilarSection extends StatelessWidget {
  const CustomSimilarSection({super.key, required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocator.get<MovieDetailsViewModel>()
            ..getMovieSuggestions(id: movieId),
      child: BlocBuilder<MovieDetailsViewModel, MovieDetailsState>(
        builder: (context, state) {
          if (state is GetMovieSuggestionsLoading) {
            return const LoadingIndicator();
          } else if (state is GetMovieSuggestionsError) {
            return ErrorIndicator(state.errorMessage);
          } else if (state is GetMovieSuggestionsSuccess) {
            final movies = state.movies;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Similar',
                  style: getBoldStyle(
                    color: ColorManager.white,
                    fontSize: FontSize.s24,
                  ),
                ),
                GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (_, index) => MovieCard(movie: movies[index]),
                  itemCount: movies.length,
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
