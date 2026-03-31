import 'package:flutter/material.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/font_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';

class ErrorIndicator extends StatelessWidget {
  final String message;

  // ignore: use_key_in_widget_constructors
  const ErrorIndicator([this.message = 'Something went wrong!']);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s18),
      ),
    );
  }
}
