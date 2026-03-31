import 'package:flutter/material.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/font_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';
import 'package:movies/core/widgets/movie_card.dart';
import 'package:movies/features/home/data/models/movie.dart';

class CustomSimilarSection extends StatelessWidget {
  const CustomSimilarSection({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
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
        // GridView.builder(
        //   scrollDirection: Axis.vertical,
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     mainAxisSpacing: 4,
        //     crossAxisSpacing: 4,
        //     childAspectRatio: 0.7,
        //   ),
        //   itemBuilder: (_, index) => MovieCard(movie: null,),
        //   itemCount: 6,
        // ),
      ],
    );
  }
}
