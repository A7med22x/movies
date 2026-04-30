import 'package:flutter/material.dart';
import 'package:movies/core/models/movie.dart';
import 'package:movies/core/resources/assets_manager.dart';
import 'package:movies/core/widgets/movie_card.dart';

class TabBarBody extends StatelessWidget {
  const TabBarBody({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (_, index) {
          return MovieCard(movie: movies[index]);
        },
        itemCount: movies.length,
      );
    }
  }
}
