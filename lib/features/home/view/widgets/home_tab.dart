import 'package:flutter/material.dart';
import 'package:movies/features/home/data/models/movie_genres_model.dart';
import 'package:movies/features/home/view/widgets/custom_carousel_slider.dart';
import 'package:movies/features/home/view/widgets/custom_section_bar.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key, required this.onViewAllClicked});

  final void Function(int genreIndex) onViewAllClicked;

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.7,
            width: double.infinity,
            child: CustomCarouselSlider(),
          ),
          const SizedBox(height: 24),
          Column(
            children: MovieGenresModel.genres
                .map(
                  (g) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CustomSectionBar(
                      sectionName: g.name,
                      onViewAllClicked: () => widget.onViewAllClicked(
                        MovieGenresModel.genres.indexOf(g),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
