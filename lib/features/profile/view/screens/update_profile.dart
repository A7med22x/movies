import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/resources/assets_manager.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';
import 'package:movies/core/routes/routes.dart';
import 'package:movies/core/utils/ui_utils.dart';
import 'package:movies/core/utils/validator.dart';
import 'package:movies/core/widgets/custom_elevated_button.dart';
import 'package:movies/core/widgets/custom_text_field.dart';
import 'package:movies/features/auth/view/widgets/avatar.dart';
import 'package:movies/features/auth/view_model/auth_states.dart';
import 'package:movies/features/auth/view_model/auth_view_model.dart';
import 'package:movies/features/profile/view/widgets/custom_avatar_sheet.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  int selectedAvatarIndex = 0;

  @override
  void initState() {
    super.initState();

    final user = context.read<AuthViewModel>().currentUser!;

    nameController.text = user.name;
    emailController.text = user.email;
    phoneController.text = user.phoneNumber;

    selectedAvatarIndex = Avatar.avatarImages.indexOf(
      user.imageAvatarURL ?? 'assets/images/avatar2.png',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthViewModel, AuthState>(
      listener: (context, state) {
        if (state is DeleteUserLoading || state is UpdateUserLoading) {
          UIUtils.showLoading(context);
        } else if (state is UpdateUserSuccess) {
          UIUtils.hideLoading(context);
          UIUtils.showSuccessMessage("Profile updated successfully");
        } else if (state is DeleteUserSuccess) {
          UIUtils.hideLoading(context);
          UIUtils.showSuccessMessage("Account deleted successfully");
          Navigator.of(context).pushReplacementNamed(Routes.login);
        } else if (state is UpdateUserError) {
          UIUtils.hideLoading(context);
          UIUtils.showErrorMessage(state.message);
        } else if (state is DeleteUserError) {
          UIUtils.hideLoading(context);
          UIUtils.showErrorMessage(state.message);
        }
      },
      child: Scaffold(
        backgroundColor: ColorManager.background,
        appBar: AppBar(
          title: Text('Update Profile'),
          foregroundColor: ColorManager.primary,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                Text(
                  'Pick Avatar',
                  style: getRegularStyle(
                    color: ColorManager.primary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    final result = await showModalBottomSheet<int>(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (_) =>
                          CustomAvatarSheet(initialIndex: selectedAvatarIndex),
                    );

                    if (result == null) return;

                    setState(() {
                      selectedAvatarIndex = result;
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 50,
                    child: Image.asset(
                      Avatar.avatarImages[selectedAvatarIndex],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  hintText: '',
                  controller: nameController,
                  validator: Validator.validateFullName,
                  prefixIconImageName: IconsAssets.user,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: '',
                  controller: phoneController,
                  validator: Validator.validatePhoneNumber,
                  prefixIconImageName: IconsAssets.phone,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.forgetPassword);
                      },
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
                const SizedBox(height: 40),
                CustomElevatedButton(
                  label: 'Delete Account',
                  onTap: () {
                    final authViewModel = context.read<AuthViewModel>();
                    UIUtils.showPasswordDialog(context).then((password) {
                      if (password == null || password.isEmpty) return;
                      authViewModel.deleteUser(password);
                    });
                  },
                  backgroundColor: ColorManager.error,
                ),
                const SizedBox(height: 16),
                CustomElevatedButton(
                  label: 'Update Data',
                  onTap: () {
                    final viewModel = context.read<AuthViewModel>();
                    final user = viewModel.currentUser;

                    if (user == null) return;

                    final updatedUser = user.copyWith(
                      name: nameController.text.trim(),
                      phoneNumber: phoneController.text.trim(),
                      imageAvatarURL: Avatar.avatarImages[selectedAvatarIndex],
                    );

                    viewModel.updateUser(user: updatedUser);
                  },
                  textColor: ColorManager.black,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
