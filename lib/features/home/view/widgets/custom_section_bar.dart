import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';
import 'package:movies/core/resources/values_manager.dart';

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
      child: Row(
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
    );
  }
}
