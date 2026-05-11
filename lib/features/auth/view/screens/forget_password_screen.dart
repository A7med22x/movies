import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/new_styles_manager.dart';
import 'package:movies/core/utils/ui_utils.dart';
import 'package:movies/core/utils/validator.dart';
import 'package:movies/core/widgets/custom_app_bar.dart';
import 'package:movies/core/widgets/custom_elevated_button.dart';
import 'package:movies/core/widgets/custom_text_field.dart';
import 'package:movies/features/auth/view_model/auth_states.dart';
import 'package:movies/features/auth/view_model/auth_view_model.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthViewModel, AuthState>(
      listener: (context, state) {
        if (state is ResetPasswordLoading) {
          UIUtils.showLoading(context);
        } else if (state is ResetPasswordSuccess) {
          UIUtils.hideLoading(context);
          UIUtils.showSuccessMessage(
            "Password reset email sent. Check your inbox or spam.",
          );
          Navigator.pop(context);
        } else if (state is ResetPasswordError) {
          UIUtils.hideLoading(context);
          UIUtils.showErrorMessage(state.message);
        }
      },
      child: Scaffold(
        backgroundColor: ColorManager.background,
        appBar: CustomAppBar(title: 'ForgetPassword'),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/forget_password.png',
                      fit: BoxFit.fill,
                      height: MediaQuery.sizeOf(context).height * 0.46,
                      width: double.infinity,
                    ),
                    CustomTextField(
                      controller: emailController,
                      prefixIconImageName: 'assets/icons/email.svg',
                      hintText: 'Email',
                      validator: Validator.validateEmail,
                    ),
                    const SizedBox(height: 22),
                    CustomElevatedButton(
                      label: 'Verify Email',
                      textStyle: NewStylesManager.textstyle20,
                      onTap: () {
                        if (!formKey.currentState!.validate()) return;

                        context.read<AuthViewModel>().resetPassword(
                          emailController.text.trim(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
