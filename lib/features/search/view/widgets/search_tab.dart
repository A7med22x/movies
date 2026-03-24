import 'package:flutter/material.dart';
import 'package:movies/core/resources/assets_manager.dart';
import 'package:movies/core/widgets/custom_text_field.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.all(16),
          child: CustomTextField(
            hintText: 'Search',
            prefixIconImageName: IconsAssets.search,
          ),
        ),
        Center(
          child: Image.asset(
            ImageAssets.empty,
            width: 124,
            height: 124,
            fit: BoxFit.fill,
          ),
        ),
        // GridView.builder(
        //   padding: const EdgeInsets.symmetric(horizontal: 16),
        //   scrollDirection: Axis.vertical,
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     mainAxisSpacing: 4,
        //     crossAxisSpacing: 4,
        //     childAspectRatio: 0.7,
        //   ),
        //   itemBuilder: (_, index) => MovieCard(),
        //   itemCount: 50,
        // ),
      ],
    );
  }
}
