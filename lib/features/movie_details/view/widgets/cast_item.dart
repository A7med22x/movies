import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/font_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';

class CastItem extends StatelessWidget {
  const CastItem({
    super.key,
    required this.imageURL,
    required this.name,
    required this.character,
  });

  final String imageURL;
  final String name;
  final String character;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorManager.lightBlack,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: imageURL,
              fit: BoxFit.fill,
              width: 70,
              height: 70,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name : $name',
                  style: getRegularStyle(
                    color: ColorManager.white,
                    fontSize: FontSize.s18,
                  ),
                ),
                Text(
                  'Character : $character',
                  style: getRegularStyle(
                    color: ColorManager.white,
                    fontSize: FontSize.s18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
