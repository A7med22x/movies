import 'package:flutter/material.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/font_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';

class GenresItem extends StatelessWidget {
  const GenresItem({super.key, required this.genre});

  final String genre;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorManager.lightBlack,
      ),
      child: Text(
        genre,
        style: getRegularStyle(
          color: ColorManager.white,
          fontSize: FontSize.s18,
        ),
      ),
    );
  }
}
