import 'package:flutter/material.dart';
import 'package:movies/core/widgets/movie_card.dart';
import 'package:movies/features/browse/view/widgets/tab_item.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  final List<TabItem> tabs = const [
    TabItem(tabName: 'Action', isSelected: true),
    TabItem(tabName: 'Comedy', isSelected: false),
    TabItem(tabName: 'Horror', isSelected: false),
    TabItem(tabName: 'Sci-Fi', isSelected: false),
    TabItem(tabName: 'Thriller', isSelected: false),
    TabItem(tabName: 'Romance', isSelected: false),
    TabItem(tabName: 'Animation', isSelected: false),
    TabItem(tabName: 'Adventure', isSelected: false),
    TabItem(tabName: 'Fantasy', isSelected: false),
    TabItem(tabName: 'Documentary', isSelected: false),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        DefaultTabController(
          length: tabs.length,
          child: TabBar(
            padding: const EdgeInsets.only(left: 16),
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            dividerColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            labelPadding: const EdgeInsets.only(right: 8),
            tabs: tabs
                .map(
                  (tab) => TabItem(
                    tabName: tab.tabName,
                    isSelected: currentIndex == tabs.indexOf(tab),
                  ),
                )
                .toList(),
            onTap: (index) {
              if (currentIndex == index) return;
              currentIndex = index;
              setState(() {});
            },
          ),
        ),
        const SizedBox(height: 24),
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
