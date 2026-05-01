import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/widgets/custom_text_field.dart';
import 'package:movies/core/widgets/loading_indicator.dart';

class UIUtils {
  static void showSuccessMessage(String message) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: ColorManager.green,
    textColor: ColorManager.white,
  );
  static void showErrorMessage([String? message]) => Fluttertoast.showToast(
    msg: message ?? 'Something Went Wrong',
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: ColorManager.error,
    textColor: ColorManager.white,
  );
  static void showLoading(BuildContext context) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => PopScope(
      canPop: false,
      child: AlertDialog(
        content: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.2,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [LoadingIndicator()],
          ),
        ),
      ),
    ),
  );

  static void hideLoading(BuildContext context) => Navigator.of(context).pop();

  static void showMessage(String message) =>
      Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT);

  static Future<String?> showPasswordDialog(BuildContext context) async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              child: CustomTextField(
                hintText: 'Password',
                prefixIconImageName: 'assets/icons/password.svg',
                isPassword: true,
                controller: controller,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, controller.text.trim());
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
