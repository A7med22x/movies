import 'package:flutter/material.dart';
import 'package:movies/core/resources/assets_manager.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';
import 'package:movies/core/widgets/custom_elevated_button.dart';
import 'package:movies/core/widgets/custom_text_field.dart';
import 'package:movies/features/profile/view/widgets/custom_avatar_sheet.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: AppBar(
        title: Text('Update Profile'),
        foregroundColor: ColorManager.primary,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Text(
              'Pick Avatar',
              style: getRegularStyle(color: ColorManager.primary, fontSize: 16),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                await showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (_) => CustomAvatarSheet(),
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 50,
                child: Image.asset('assets/images/avatar1.png'),
              ),
            ),
            const SizedBox(height: 32),
            CustomTextField(
              hintText: '',
              prefixIconImageName: IconsAssets.user,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: '',
              prefixIconImageName: IconsAssets.phone,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Text(
                    'Reset Password',
                    style: getRegularStyle(
                      color: ColorManager.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            CustomElevatedButton(
              label: 'Delete Account',
              onTap: () {},
              backgroundColor: ColorManager.error,
            ),
            const SizedBox(height: 16),
            CustomElevatedButton(
              label: 'Update Data',
              onTap: () {},
              textColor: ColorManager.black,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
