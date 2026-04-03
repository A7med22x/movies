import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/new_styles_manager.dart';
import 'package:movies/core/routes/routes.dart';
import 'package:movies/core/utils/validator.dart';
import 'package:movies/core/widgets/custom_elevated_button.dart';
import 'package:movies/core/widgets/custom_text_field.dart';
import 'package:movies/core/widgets/firebase_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.25,
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  CustomTextField(
                    prefixIconImageName: 'assets/icons/email.svg',
                    hintText: 'Email',
                    controller: emailController,
                    validator: Validator.validateEmail,

                    //textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 22),
                  CustomTextField(
                    hintText: 'Password',
                    prefixIconImageName: 'assets/icons/password.svg',
                    isPassword: true,
                    controller: passwordController,
                    validator: Validator.validatePassword,
                  ),
                  const SizedBox(height: 17),
                  Row(
                    mainAxisAlignment: .end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pushNamed(Routes.forgetPassword);
                        },
                        child: Text(
                          'Forget Password ?',
                          textAlign: TextAlign.right,
                          style: NewStylesManager.textstyle14.copyWith(
                            color: ColorManager.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomElevatedButton(
                    label: 'Login',
                    onTap: login,
                    textStyle: NewStylesManager.textstyle20,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        'Don’t Have Account ? ',
                        style: NewStylesManager.textstyle14,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pushReplacementNamed(Routes.register);
                        },
                        child: Text(
                          'Create One',
                          style: NewStylesManager.textstyle14PrimaryBold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 27),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: ColorManager.primary,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'OR',
                            style: TextStyle(
                              color: ColorManager.primary,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: ColorManager.primary,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  CustomElevatedButton(
                    label: 'Login With Google',
                    textStyle: NewStylesManager.textstyle20,
                    onTap: () {},
                    prefixIcon: SvgPicture.asset('assets/icons/google.svg'),
                  ),
                  const SizedBox(height: 30),
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

  void login() {
    if (formKey.currentState!.validate()) {
      FirebaseServices.login(
        email: emailController.text,
        password: passwordController.text,
      ).then((user) {
        Navigator.of(context).pushReplacementNamed(Routes.home);
      });
    }
  }
}
