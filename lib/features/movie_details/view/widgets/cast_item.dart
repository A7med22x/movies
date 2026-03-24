import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/font_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';

class CastItem extends StatelessWidget {
  const CastItem({super.key});

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
              imageUrl:
                  'https://s.yimg.com/fz/api/res/1.2/g3V9YbR4g4IB.Jqdqf0P0w--~C/YXBwaWQ9c3JjaGRkO2ZpPWZpbGw7aD0xOTI7cHhvZmY9MDtweW9mZj0wO3E9ODA7dz0xOTI-/https://s.yimg.com/zb/imgv1/95fab536-8164-3900-a4a5-81bb7af78cb5/s_500x500',
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
                  'Name : Hayley Atwell',
                  style: getRegularStyle(
                    color: ColorManager.white,
                    fontSize: FontSize.s18,
                  ),
                ),
                Text(
                  'Character : Wanda Maximoff / The Scarlet Witch',
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
