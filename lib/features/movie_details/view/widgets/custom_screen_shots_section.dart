import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/font_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';

class CustomScreenShotsSection extends StatelessWidget {
  const CustomScreenShotsSection({super.key, required this.imagesURL});

  final List<String> imagesURL;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Screen Shots',
          style: getBoldStyle(
            color: ColorManager.white,
            fontSize: FontSize.s24,
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) => ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: imagesURL[index],
              errorWidget: (context, url, error) => Image.network(
                'https://4ddig.tenorshare.com/images/photo-recovery/images-not-found.jpg',
                fit: BoxFit.fill,
              ),
              fit: BoxFit.fill,
              width: double.infinity,
            ),
          ),
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemCount: 3,
        ),
      ],
    );
  }
}
