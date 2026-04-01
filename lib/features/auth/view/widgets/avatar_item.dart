import 'package:flutter/material.dart';
import 'package:movies/features/auth/view/widgets/avatar.dart';

class AvatarItem extends StatefulWidget {
  final int index;
  const AvatarItem({super.key, required this.index});

  @override
  State<AvatarItem> createState() => _AvatarItemState();
}

class _AvatarItemState extends State<AvatarItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: ClipOval(
        child: Image.asset(
          Avatar.avatarImages[widget.index],
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
