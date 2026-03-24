import 'package:flutter/material.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/font_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';

class CustomSummarySection extends StatelessWidget {
  const CustomSummarySection({super.key, required this.summary});

  final String summary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary',
          style: getBoldStyle(
            color: ColorManager.white,
            fontSize: FontSize.s24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          summary,
          style: getRegularStyle(
            color: ColorManager.white,
            fontSize: FontSize.s16,
          ),
        ),
      ],
    );
  }
}
