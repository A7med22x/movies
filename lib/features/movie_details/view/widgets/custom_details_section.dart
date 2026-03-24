import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/core/resources/assets_manager.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/font_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';
import 'package:movies/core/widgets/custom_elevated_button.dart';

class CustomDetailsSection extends StatelessWidget {
  const CustomDetailsSection({
    super.key,
    required this.year,
    required this.title,
  });

  final String year;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_new),
              color: ColorManager.white,
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(IconsAssets.marked),
              color: ColorManager.white,
            ),
          ],
        ),
        const Spacer(),
        Image.asset(
          ImageAssets.watch,
          width: 100,
          height: 100,
          fit: BoxFit.fill,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              title,
              style: getBoldStyle(
                color: ColorManager.white,
                fontSize: FontSize.s24,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              year,
              style: getBoldStyle(
                color: ColorManager.white,
                fontSize: FontSize.s24,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomElevatedButton(
            label: 'Watch',
            onTap: () {},
            backgroundColor: ColorManager.error,
          ),
        ),
      ],
    );
  }
}
