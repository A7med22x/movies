import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/new_styles_manager.dart';
import 'package:movies/core/routes/routes.dart';
import 'package:movies/core/utils/validator.dart';
import 'package:movies/core/widgets/custom_app_bar.dart';
import 'package:movies/core/widgets/custom_elevated_button.dart';
import 'package:movies/core/widgets/custom_text_field.dart';
import 'package:movies/features/auth/view/widgets/avatar.dart';
import 'package:movies/features/auth/view/widgets/avatar_item.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String selectedLanguage = 'us';
  Widget _buildLanguageFlag({
    required String imagePath,
    required String languageCode,
  }) {
    final bool isSelected = selectedLanguage == languageCode;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        setState(() {
          selectedLanguage = languageCode;
        });
      },
      child: isSelected
          ? CircleAvatar(
              radius: 25,
              backgroundColor: ColorManager.primary,
              child: CircleAvatar(
                radius: 17,
                backgroundImage: AssetImage(imagePath),
              ),
            )
          : ClipOval(
              child: Image.asset(
                imagePath,
                width: 34,
                height: 34,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: const CustomAppBar(title: 'Register'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 9),
                  CarouselSlider.builder(
                    itemCount: Avatar.avatarImages.length,
                    itemBuilder: (_, index, _) => AvatarItem(index: index),
                    options: CarouselOptions(
                      height: MediaQuery.sizeOf(context).height * 0.16,
                      viewportFraction: 0.33,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.35,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Avatar', style: NewStylesManager.textstyle16),
                  const SizedBox(height: 12),
                  CustomTextField(
                    prefixIconImageName: 'assets/icons/name.svg',
                    hintText: 'Name',
                    controller: nameController,
                    validator: Validator.validateFullName,
                  ),
                  const SizedBox(height: 22),
                  CustomTextField(
                    prefixIconImageName: 'assets/icons/email.svg',
                    hintText: 'Email',
                    controller: emailController,
                    validator: Validator.validateEmail,
                  ),
                  const SizedBox(height: 22),
                  CustomTextField(
                    hintText: 'Password',
                    prefixIconImageName: 'assets/icons/password.svg',
                    isPassword: true,
                    controller: passwordController,
                    validator: Validator.validatePassword,
                  ),
                  const SizedBox(height: 22),
                  CustomTextField(
                    hintText: 'Confirm Password',
                    prefixIconImageName: 'assets/icons/password.svg',
                    isPassword: true,
                    controller: confirmPasswordController,
                    validator: (value) => Validator.validateConfirmPassword(
                      value,
                      passwordController.text,
                    ),
                  ),
                  const SizedBox(height: 22),
                  CustomTextField(
                    hintText: 'Phone Number',
                    prefixIconImageName: 'assets/icons/phone.svg',
                    controller: phoneNumberController,
                    validator: Validator.validatePhoneNumber,
                  ),
                  const SizedBox(height: 20,),
                  CustomElevatedButton(
                    label: 'Create Account',
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                       Navigator.of(context).pushReplacementNamed(Routes.login); 
                      }
                      
                    },
                    textStyle: NewStylesManager.textstyle20,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        'Already Have Account ? ',
                        style: NewStylesManager.textstyle14,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pushReplacementNamed(Routes.login);
                        },
                        child: Text(
                          'Login',
                          style: NewStylesManager.textstyle14PrimaryBold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorManager.primary),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildLanguageFlag(
                              imagePath: 'assets/images/us.png',
                              languageCode: 'us',
                            ),
                            const SizedBox(width: 8),
                            _buildLanguageFlag(
                              imagePath: 'assets/images/eg.png',
                              languageCode: 'eg',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
