import 'package:flutter/material.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies/core/resources/assets_manager.dart';
import 'package:movies/core/widgets/movie_card.dart';
import 'package:movies/features/home/view/widgets/custom_section_bar.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.7,
          width: double.infinity,
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl:
                    'https://tse1.mm.bing.net/th/id/OIP.xRMA0d0BJ4C_gg5UVSdg6gHaLH?pid=Api&h=220&P=0',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Image.asset(
                    ImageAssets.availableNow,
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    height: MediaQuery.sizeOf(context).height * 0.1,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: CarouselSlider(
                      items: [MovieCard()],
                      options: CarouselOptions(
                        height: MediaQuery.sizeOf(context).height * 0.6,
                        enableInfiniteScroll: true,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        viewportFraction: 0.5,
                      ),
                    ),
                  ),
                  Image.asset(
                    ImageAssets.watchNow,
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    height: MediaQuery.sizeOf(context).height * 0.1,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        CustomSectionBar(sectionName: 'Action', onViewAllClicked: () {}),
        const SizedBox(height: 8),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.3,
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 16),
            scrollDirection: Axis.horizontal,
            physics: const ScrollPhysics(),
            itemBuilder: (_, index) => SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.4,
              child: MovieCard(),
            ),
            separatorBuilder: (_, _) => const SizedBox(width: 4),
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
