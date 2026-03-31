import 'package:flutter/material.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/font_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';
import 'package:movies/features/movie_details/data/models/cast.dart';
import 'package:movies/features/movie_details/view/widgets/cast_item.dart';

class CustomCastSection extends StatelessWidget {
  const CustomCastSection({super.key, required this.cast});

  final List<Cast> cast;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cast',
          style: getBoldStyle(
            color: ColorManager.white,
            fontSize: FontSize.s24,
          ),
        ),
        const SizedBox(height: 8),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) => CastItem(
            name: cast[index].name,
            character: cast[index].characterName,
            imageURL: cast[index].urlSmallImage,
          ),
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemCount: cast.length,
        ),
      ],
    );
  }
}
