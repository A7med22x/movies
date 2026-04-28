import 'package:flutter/material.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';
import 'package:movies/core/routes/routes.dart';
import 'package:movies/core/widgets/custom_elevated_button.dart';

class ProfileTabHeaderContent extends StatelessWidget {
  const ProfileTabHeaderContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    child: Image.asset('assets/images/avatar1.png'),
                  ),
                  SizedBox(
                    width: 120,
                    child: Text(
                      'John Safwat',
                      style: getBoldStyle(
                        color: ColorManager.white,
                        fontSize: 18,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '12',
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
                    '10',
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
                onTap: () {},
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
    );
  }
}
