import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/core/resources/color_manager.dart';

class CustomBottomNavBarItem extends BottomNavigationBarItem {
  final String iconPath;
  final String title;

  CustomBottomNavBarItem(this.iconPath, this.title)
    : super(
        label: title,
        icon: SvgPicture.asset(
          iconPath,
          colorFilter: ColorFilter.mode(ColorManager.white, BlendMode.srcIn),
        ),
        activeIcon: SvgPicture.asset(
          iconPath,
          colorFilter: ColorFilter.mode(ColorManager.primary, BlendMode.srcIn),
        ),
      );
}
