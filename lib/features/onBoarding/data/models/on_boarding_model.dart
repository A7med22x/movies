import 'package:movies/core/resources/assets_manager.dart';

class OnBoardingModel {
  final String imageName;
  final String header;
  final String? body;
  final String buttonName;
  final String? button2Name;

  OnBoardingModel({
    required this.imageName,
    required this.header,
    this.body,
    required this.buttonName,
    this.button2Name,
  });

  static List<OnBoardingModel> onBoardingModels = [
    OnBoardingModel(
      imageName: ImageAssets.onBoardingImage1,
      header: 'Find Your Next Favorite Movie Here',
      buttonName: 'Explore Now',
      body:
          "Get access to a huge library of movies to suit all tastes. You will surely like it.",
    ),
    OnBoardingModel(
      imageName: ImageAssets.onBoardingImage2,
      header: 'Discover Movies',
      buttonName: 'Next',
      body:
          "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
    ),
    OnBoardingModel(
      imageName: ImageAssets.onBoardingImage3,
      header: 'Explore All Genres',
      buttonName: 'Next',
      button2Name: 'Back',
      body:
          "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
    ),
    OnBoardingModel(
      imageName: ImageAssets.onBoardingImage4,
      header: 'Create Watchlists',
      buttonName: 'Next',
      button2Name: 'Back',
      body:
          "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
    ),
    OnBoardingModel(
      imageName: ImageAssets.onBoardingImage5,
      header: 'Rate, Review, and Learn',
      buttonName: 'Next',
      button2Name: 'Back',
      body:
          "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
    ),
    OnBoardingModel(
      imageName: ImageAssets.onBoardingImage6,
      header: 'Start Watching Now',
      buttonName: 'Finish',
      button2Name: 'Back',
    ),
  ];
}
