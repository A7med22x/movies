import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies/core/resources/color_manager.dart';
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
}
