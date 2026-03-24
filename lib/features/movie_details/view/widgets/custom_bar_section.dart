import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/core/resources/assets_manager.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/font_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';

class CustomBarSection extends StatelessWidget {
  const CustomBarSection({
    super.key,
    required this.rating,
    required this.time,
    required this.like,
  });

  final String rating;
  final String time;
  final String like;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: ColorManager.lightBlack,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                IconsAssets.heart,
                width: 28,
                height: 28,
                colorFilter: ColorFilter.mode(
                  ColorManager.primary,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                like,
                style: getBoldStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s24,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: ColorManager.lightBlack,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                IconsAssets.time,
                width: 28,
                height: 28,
                colorFilter: ColorFilter.mode(
                  ColorManager.primary,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                time,
                style: getBoldStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s24,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: ColorManager.lightBlack,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                IconsAssets.star,
                width: 28,
                height: 28,
                colorFilter: ColorFilter.mode(
                  ColorManager.primary,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                rating,
                style: getBoldStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s24,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
