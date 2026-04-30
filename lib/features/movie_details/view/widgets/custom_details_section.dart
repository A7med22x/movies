import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/core/resources/assets_manager.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/font_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';
import 'package:movies/core/widgets/custom_elevated_button.dart';
import 'package:movies/features/auth/view_model/auth_states.dart';
import 'package:movies/features/auth/view_model/auth_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDetailsSection extends StatelessWidget {
  const CustomDetailsSection({
    super.key,
    required this.year,
    required this.title,
    required this.movieURL,
    required this.movieId,
  });

  final String year;
  final String title;
  final String movieURL;
  final String movieId;

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
            BlocBuilder<AuthViewModel, AuthState>(
              builder: (context, state) {
                final authViewModel = context.read<AuthViewModel>();

                final isFavorite = authViewModel.checkMovieIsFavorite(movieId);

                return IconButton(
                  onPressed: () {
                    if (isFavorite) {
                      authViewModel.removeMovieFromFavorites(movieId);
                    } else {
                      authViewModel.addMovieToFavorites(movieId);
                    }
                  },
                  icon: SvgPicture.asset(
                    IconsAssets.marked,
                    colorFilter: ColorFilter.mode(
                      isFavorite ? ColorManager.primary : ColorManager.white,
                      BlendMode.srcIn,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            watchNow(movieURL);
          },
          child: Image.asset(
            ImageAssets.watch,
            width: 100,
            height: 100,
            fit: BoxFit.fill,
          ),
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
            onTap: () {
              watchNow(movieURL);
            },
            backgroundColor: ColorManager.error,
          ),
        ),
      ],
    );
  }

  Future<void> watchNow(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }
}
