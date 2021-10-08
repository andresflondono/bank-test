import 'package:flutter/material.dart';

class AdaptScreen {
  static MediaQueryData mediaQueryData;
  static double width;
  static double height;

  static initAdapt(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    width = mediaQueryData.size.width;
    height = mediaQueryData.size.height;
  }

  static screenWidth() {
    return width;
  }

  static screenHeight() {
    return height;
  }
}
