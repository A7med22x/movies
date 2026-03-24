import 'package:flutter/material.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/font_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';
import 'package:movies/core/resources/values_manager.dart';
import 'package:movies/core/widgets/custom_elevated_button.dart';
import 'package:movies/features/onBoarding/data/models/on_boarding_model.dart';

class PageViewItem extends StatelessWidget {
  final OnBoardingModel onBoardingModel;
  final int currentIndex;
  final Function() onNext;
  final Function() onBack;
  final Function() onFinish;

  const PageViewItem({
    super.key,
    required this.onBoardingModel,
    required this.currentIndex,
    required this.onNext,
    required this.onBack,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          onBoardingModel.imageName,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.s16,
              vertical: Insets.s20,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: currentIndex == 0
                  ? Colors.transparent
                  : ColorManager.background,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  onBoardingModel.header,
                  style: getBoldStyle(
                    color: ColorManager.white,
                    fontSize: currentIndex == 0 ? FontSize.s36 : FontSize.s24,
                  ),
                ),
                const SizedBox(height: Sizes.s24),
                if (onBoardingModel.body != null)
                  Text(
                    onBoardingModel.body!,
                    style: getRegularStyle(
                      color: ColorManager.white,
                      fontSize: FontSize.s20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: Sizes.s16),
                CustomElevatedButton(
                  label: onBoardingModel.buttonName,
                  onTap: onNext,
                ),
                const SizedBox(height: Sizes.s16),
                onBoardingModel.button2Name == null
                    ? const SizedBox()
                    : CustomElevatedButton(
                        backgroundColor: ColorManager.lightBlack,
                        label: onBoardingModel.button2Name!,
                        onTap: onBack,
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
