import 'package:flutter/material.dart';
import 'package:movies/core/resources/color_manager.dart';

class CustomAvatarSheet extends StatefulWidget {
  const CustomAvatarSheet({super.key});

  @override
  State<CustomAvatarSheet> createState() => _CustomAvatarSheetState();
}

class _CustomAvatarSheetState extends State<CustomAvatarSheet> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorManager.lightBlack,
      ),
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {
              if (currentIndex == index) return;
              currentIndex = index;
              setState(() {});
            },
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 36,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: (currentIndex == index)
                      ? ColorManager.primary
                      : Colors.transparent,
                  border: Border.all(width: 1, color: ColorManager.primary),
                ),
                child: Image.asset('assets/images/avatar${index + 1}.png'),
              ),
            ),
          );
        },
        itemCount: 9,
      ),
    );
  }
}
