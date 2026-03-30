import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/features/home/data/models/movie.dart';
import 'package:movies/features/movie_details/view/widgets/custom_bar_section.dart';
import 'package:movies/features/movie_details/view/widgets/custom_cast_section.dart';
import 'package:movies/features/movie_details/view/widgets/custom_details_section.dart';
import 'package:movies/features/movie_details/view/widgets/custom_genres_section.dart';
import 'package:movies/features/movie_details/view/widgets/custom_screen_shots_section.dart';
import 'package:movies/features/movie_details/view/widgets/custom_similar_section.dart';
import 'package:movies/features/movie_details/view/widgets/custom_summary_section.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final movie = ModalRoute.of(context)?.settings.arguments as Movie;
    final List<String> imagesURL = [
      'https://tse2.mm.bing.net/th/id/OIP.Jo8oYmsbxEI5QSGNx9wtaQHaD1?pid=Api&h=220&P=0',
      'https://tse2.mm.bing.net/th/id/OIP.Jo8oYmsbxEI5QSGNx9wtaQHaD1?pid=Api&h=220&P=0',
      'https://tse2.mm.bing.net/th/id/OIP.Jo8oYmsbxEI5QSGNx9wtaQHaD1?pid=Api&h=220&P=0',
    ];

    return Scaffold(
      backgroundColor: ColorManager.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.9,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: movie.largeCoverImage!,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ColorManager.background.withValues(alpha: .2),
                          ColorManager.background,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 24,
                    right: 0,
                    left: 0,
                    bottom: size.height * .12,
                    child: CustomDetailsSection(
                      year: '${movie.year}',
                      title: movie.title!,
                    ),
                  ),
                  Positioned(
                    right: 16,
                    left: 16,
                    bottom: 16,
                    child: CustomBarSection(
                      rating: '${movie.rating}',
                      time: '${movie.runtime}',
                      like: '50',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomScreenShotsSection(imagesURL: imagesURL),
                  const SizedBox(height: 16),
                  //CustomSimilarSection(movie: ,),
                  const SizedBox(height: 16),
                  CustomSummarySection(summary: movie.summary!),
                  const SizedBox(height: 16),
                  CustomCastSection(),
                  const SizedBox(height: 16),
                  CustomGenresSection(genres: movie.genres!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
