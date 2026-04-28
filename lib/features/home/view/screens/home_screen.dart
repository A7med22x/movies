import 'package:flutter/material.dart';
import 'package:movies/core/resources/assets_manager.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/features/browse/view/widgets/browse_tab.dart';
import 'package:movies/features/home/view/widgets/custom_bottom_nav_bar_item.dart';
import 'package:movies/features/home/view/widgets/home_tab.dart';
import 'package:movies/features/profile/view/widgets/profile_tab.dart';
import 'package:movies/features/search/view/widgets/search_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  int browseInitialIndex = 0;
  List<Widget> get tabs => [
    HomeTab(onViewAllClicked: onViewAllClicked),
    const SearchTab(),
    BrowseTab(initialIndex: browseInitialIndex),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: tabs[currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: SizedBox(
            height: 70,
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (value) => changeSelectedIndex(value),
              backgroundColor: ColorManager.lightBlack,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: ColorManager.primary,
              unselectedItemColor: ColorManager.white,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                CustomBottomNavBarItem(IconsAssets.home, 'Home'),
                CustomBottomNavBarItem(IconsAssets.search, 'Search'),
                CustomBottomNavBarItem(IconsAssets.browse, 'Browse'),
                CustomBottomNavBarItem(IconsAssets.profile, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changeSelectedIndex(int selectedIndex) {
    if (currentIndex == selectedIndex) return;
    currentIndex = selectedIndex;
    setState(() {});
  }

  void onViewAllClicked(int genreIndex) {
    browseInitialIndex =genreIndex;
    currentIndex = 2;
    tabs[2] = BrowseTab(initialIndex: genreIndex);
    setState(() {});
  }
}

