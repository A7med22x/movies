import 'package:flutter/material.dart';
import 'package:movies/core/routes/routes.dart';
import 'package:movies/features/onBoarding/data/models/on_boarding_model.dart';
import 'package:movies/features/onBoarding/view/widgets/page_view_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;

  late final PageController pageController = PageController(
    initialPage: currentIndex,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: pageController,
              onPageChanged: (index) {
                currentIndex = index;
                setState(() {});
              },
              itemBuilder: (_, index) => PageViewItem(
                onBoardingModel: OnBoardingModel.onBoardingModels[currentIndex],
                currentIndex: currentIndex,
                onBack: onBackBottonClicked,
                onNext: onNextBottonClicked,
                onFinish: () {
                  onSkipBottonClicked(context);
                },
              ),
              itemCount: OnBoardingModel.onBoardingModels.length,
            ),
          ),
        ],
      ),
    );
  }

  void onNextBottonClicked() {
    if (currentIndex < OnBoardingModel.onBoardingModels.length - 1) {
      currentIndex++;
      setState(() {});
      pageController.jumpToPage(currentIndex);
    } else {
      onSkipBottonClicked(context);
    }
  }

  void onBackBottonClicked() {
    if (currentIndex > 0) {
      currentIndex--;
      setState(() {});
      pageController.jumpToPage(currentIndex);
    }
  }

  Future<void> onSkipBottonClicked(BuildContext context) async {
    Navigator.of(context).pushReplacementNamed(Routes.login);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('hasSeenIntro', true);
  }
}
