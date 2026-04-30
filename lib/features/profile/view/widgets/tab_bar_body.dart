import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/resources/assets_manager.dart';
import 'package:movies/core/widgets/movie_card.dart';
import 'package:movies/features/profile/view_model/profile_states.dart';
import 'package:movies/features/profile/view_model/profile_view_model.dart';

class TabBarBody extends StatefulWidget {
  const TabBarBody({super.key, required this.ids});

  final List<String> ids;

  @override
  State<TabBarBody> createState() => _TabBarBodyState();
}

class _TabBarBodyState extends State<TabBarBody> {
  @override
  void initState() {
    super.initState();

    if (widget.ids.isNotEmpty) {
      context.read<ProfileViewModel>().getMoviesByIds(widget.ids);
    }
  }

  @override
  void didUpdateWidget(covariant TabBarBody oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.ids != oldWidget.ids) {
      if (widget.ids.isNotEmpty) {
        context.read<ProfileViewModel>().getMoviesByIds(widget.ids);
      } else {
        context.read<ProfileViewModel>().clearMovies();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.ids.isEmpty) {
      return Center(
        child: Image.asset(
          ImageAssets.empty,
          width: 124,
          height: 124,
          fit: BoxFit.fill,
        ),
      );
    }

    return BlocBuilder<ProfileViewModel, ProfileState>(
      builder: (context, state) {
        if (state is GetMoviesByIdsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetMoviesByIdsError) {
          return Center(child: Text(state.errorMessage));
        }

        if (state is GetMoviesByIdsSuccess) {
          final movies = state.movies;

          if (movies.isEmpty) {
            return Center(
              child: Image.asset(
                ImageAssets.empty,
                width: 124,
                height: 124,
                fit: BoxFit.fill,
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: movies.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (_, index) {
              return MovieCard(movie: movies[index]);
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
