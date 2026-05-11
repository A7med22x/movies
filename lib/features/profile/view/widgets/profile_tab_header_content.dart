import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';
import 'package:movies/core/routes/routes.dart';
import 'package:movies/core/utils/ui_utils.dart';
import 'package:movies/core/widgets/custom_elevated_button.dart';
import 'package:movies/features/auth/view_model/auth_states.dart';
import 'package:movies/features/auth/view_model/auth_view_model.dart';

class ProfileTabHeaderContent extends StatelessWidget {
  const ProfileTabHeaderContent({
    super.key,
    required this.name,
    required this.wishListCount,
    required this.historyCount,
    required this.imageURL,
  });

  final String name;
  final String imageURL;
  final int wishListCount;
  final int historyCount;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthViewModel, AuthState>(
      listener: (context, state) {
        if (state is LogoutLoading) {
          UIUtils.showLoading(context);
        } else if (state is LogoutSuccess) {
          UIUtils.hideLoading(context);
          Navigator.of(context).pushReplacementNamed(Routes.login);
        } else if (state is LogoutError) {
          UIUtils.hideLoading(context);
          UIUtils.showErrorMessage(state.message);
        }
      },
      child: Container(
        padding: EdgeInsets.all(16),
        height: 300,
        color: ColorManager.lightBlack,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 50,
                      child: Image.asset(imageURL),
                    ),
                    SizedBox(
                      width: 150,
                      child: Text(
                        name,
                        style: getBoldStyle(
                          color: ColorManager.white,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      wishListCount.toString(),
                      style: getBoldStyle(
                        color: ColorManager.white,
                        fontSize: 36,
                      ),
                    ),
                    Text(
                      'Wish List',
                      style: getBoldStyle(
                        color: ColorManager.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    Text(
                      historyCount.toString(),
                      style: getBoldStyle(
                        color: ColorManager.white,
                        fontSize: 36,
                      ),
                    ),
                    Text(
                      'History',
                      style: getBoldStyle(
                        color: ColorManager.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    label: 'Edit Profile',
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.updateProfile);
                    },
                    textColor: ColorManager.black,
                  ),
                ),
                const SizedBox(width: 8),
                CustomElevatedButton(
                  label: 'Exit',
                  onTap: () {
                    context.read<AuthViewModel>().logout();
                  },
                  suffixIcon: Icon(
                    Icons.exit_to_app_outlined,
                    size: 24,
                    color: ColorManager.white,
                  ),
                  backgroundColor: ColorManager.error,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
