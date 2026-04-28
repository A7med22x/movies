import 'package:flutter/material.dart';
import 'package:movies/core/resources/assets_manager.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/features/profile/view/widgets/profile_tab_header_content.dart';
import 'package:movies/features/profile/view/widgets/tab_bar_body.dart';
import 'package:movies/features/profile/view/widgets/tab_bar_item.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Container(
                color: Colors.red, // 👈 debug
                child: ProfileTabHeaderContent(),
              ),
            ),
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              toolbarHeight: 16,
              backgroundColor: ColorManager.lightBlack,
              bottom: TabBar(
                dividerHeight: 0,
                indicatorColor: ColorManager.primary,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  TabBarItem(
                    iconPath: IconsAssets.wishlist,
                    title: 'Wish List',
                  ),
                  TabBarItem(iconPath: IconsAssets.history, title: 'History'),
                ],
              ),
            ),
          ];
        },

        body: TabBarView(children: [TabBarBody(), TabBarBody()]),
      ),
    );
  }
}
