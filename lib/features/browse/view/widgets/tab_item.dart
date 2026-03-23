import 'package:flutter/material.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';

class TabItem extends StatelessWidget {
  final String tabName;
  final bool isSelected;

  const TabItem({super.key, required this.tabName, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? ColorManager.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: isSelected
            ? null
            : Border.all(color: ColorManager.primary, width: 2),
      ),
      child: Center(
        child: Text(
          tabName,
          style: getBoldStyle(
            fontSize: 24,
            color: isSelected ? ColorManager.black : ColorManager.primary,
          ),
        ),
      ),
    );
  }
}
