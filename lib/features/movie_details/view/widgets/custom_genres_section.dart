import 'package:flutter/material.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/font_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';
import 'package:movies/features/movie_details/view/widgets/genres_item.dart';

class CustomGenresSection extends StatelessWidget {
  const CustomGenresSection({super.key, required this.genres});

  final List<String> genres;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Genres',
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
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 2,
          ),
          itemBuilder: (_, index) => GenresItem(genre: genres[index],),
          itemCount: genres.length,
        ),
      ],
    );
  }
}
