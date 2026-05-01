import 'package:flutter/material.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/features/auth/view/widgets/avatar.dart';

class CustomAvatarSheet extends StatefulWidget {
  const CustomAvatarSheet({super.key, required this.initialIndex});

  final int initialIndex;

  @override
  State<CustomAvatarSheet> createState() => _CustomAvatarSheetState();
}

class _CustomAvatarSheetState extends State<CustomAvatarSheet> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
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
          final isSelected = currentIndex == index;
          return InkWell(
            onTap: () {
              if (currentIndex == index) return;
              setState(() {
                currentIndex = index;
              });
              Navigator.pop(context, currentIndex);
            },
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 36,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: isSelected
                      ? ColorManager.primary.withValues(alpha: 0.52)
                      : Colors.transparent,
                  border: Border.all(width: 1, color: ColorManager.primary),
                ),
                child: Image.asset(Avatar.avatarImages[index]),
              ),
            ),
          );
        },
        itemCount: Avatar.avatarImages.length,
      ),
    );
  }
}
