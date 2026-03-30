import 'package:flutter/material.dart';
import 'package:movies/core/resources/color_manager.dart';

abstract class NewStylesManager {
  static const textstyle16 = TextStyle(fontSize: 16, color: ColorManager.white);

  static const textstyle14 = TextStyle(color: ColorManager.white, fontSize: 14);
  static const textstyle14PrimaryBold = TextStyle(
    color: ColorManager.primary,
    fontSize: 14,
    fontWeight: .w900,
  );

  static const textstyle20 = TextStyle(
    color: ColorManager.lightBlack,
    fontSize: 20,
  );
}
