import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/di/service_locator.dart';
import 'package:movies/core/resources/assets_manager.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/features/browse/view/widgets/browse_tab.dart';
import 'package:movies/features/home/view/widgets/custom_bottom_nav_bar_item.dart';
import 'package:movies/features/home/view/widgets/home_tab.dart';
import 'package:movies/features/home/view_model/movies_view_model.dart';
import 'package:movies/features/search/view/widgets/search_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [
    const HomeTab(),
    const SearchTab(),
    const BrowseTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<MoviesViewModel>(),
      child: Scaffold(
        backgroundColor: ColorManager.background,
        body: tabs[currentIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.08,
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
      ),
    );
  }

  void changeSelectedIndex(int selectedIndex) {
    if (currentIndex == selectedIndex) return;
    currentIndex = selectedIndex;
    setState(() {});
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile Tab'));
  }
}
