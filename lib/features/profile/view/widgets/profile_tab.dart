import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/resources/assets_manager.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/features/auth/view_model/auth_view_model.dart';
import 'package:movies/features/profile/view/widgets/profile_tab_header_content.dart';
import 'package:movies/features/profile/view/widgets/tab_bar_body.dart';
import 'package:movies/features/profile/view/widgets/tab_bar_item.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthViewModel>().currentUser!;
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Container(
                color: Colors.red,
                child: ProfileTabHeaderContent(
                  name: user.name,
                  wishListCount: user.favoriteMoviesIds!.length,
                  historyCount: user.moviesWatchedHistoryIds!.length,
                  imageURL: user.imageAvatarURL ?? 'assets/images/avatar2.png',
                ),
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

        body: TabBarView(
          children: [
            TabBarBody(ids: user.favoriteMoviesIds!),
            TabBarBody(ids: user.moviesWatchedHistoryIds!),
          ],
        ),
      ),
    );
  }
}
