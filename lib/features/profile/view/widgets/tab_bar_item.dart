import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';

class TabBarItem extends StatelessWidget {
  const TabBarItem({super.key, required this.iconPath, required this.title});

  final String iconPath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 24,
          height: 24,
          fit: BoxFit.scaleDown,
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: getRegularStyle(fontSize: 20, color: ColorManager.white),
        ),
      ],
    );
  }
}
