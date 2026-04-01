import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/di/service_locator.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';
import 'package:movies/core/resources/values_manager.dart';
import 'package:movies/core/widgets/error_indicator.dart';
import 'package:movies/core/widgets/loading_indicator.dart';
import 'package:movies/core/widgets/movie_card.dart';
import 'package:movies/features/home/view_model/movies_states.dart';
import 'package:movies/features/home/view_model/movies_view_model.dart';

class CustomSectionBar extends StatelessWidget {
  final String sectionName;
  final VoidCallback onViewAllClicked;

  const CustomSectionBar({
    super.key,
    required this.sectionName,
    required this.onViewAllClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Insets.s16.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionName,
                style: getMediumStyle(fontSize: 18, color: ColorManager.white),
              ),
              InkWell(
                onTap: onViewAllClicked,
                child: Row(
                  children: [
                    Text(
                      'See More',
                      style: getMediumStyle(
                        color: ColorManager.primary,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: ColorManager.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          BlocProvider(
            create: (_) => serviceLocator.get<MoviesViewModel>()
              ..getGenersMovies(
                page: 1,
                genres: sectionName == 'All' ? '' : sectionName,
                sortBy: 'year',
              ),
            child: BlocBuilder<MoviesViewModel, MoviesState>(
              builder: (context, state) {
                if (state is GetGenersLoading) {
                  return const LoadingIndicator();
                } else if (state is GetGenersError) {
                  return ErrorIndicator(state.message);
                } else if (state is GetGenersSuccess) {
                  final movies = state.movies;
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.3,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const ScrollPhysics(),
                      itemBuilder: (_, index) => SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        child: MovieCard(movie: movies[index]),
                      ),
                      separatorBuilder: (_, _) => const SizedBox(width: 4),
                      itemCount: movies.length,
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
