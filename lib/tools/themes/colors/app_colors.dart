import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color.fromARGB(255, 137, 5, 170);
  static const Color secondary = Color.fromARGB(223, 255, 17, 255);
  static const Color dark = Colors.black;
  static const Color darkGrey = Color(0xFF121212);
  static const Color darkBackground = Color(0xFF1E1E1E);
  static const Color black1 = Color(0xff1D1F22);
  static const Color black2 = Color.fromARGB(253, 38, 6, 48);
  static const Color white = Colors.white;
  static const Color white2 = Color.fromARGB(252, 241, 217, 248);
  static const Color grey = Colors.grey;
  static const Color lightGrey = Color.fromARGB(255, 224, 224, 224);
  static const Color gold = Color.fromARGB(255, 252, 216, 13);

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primary,
    onPrimary: white,
    secondary: secondary,
    onSecondary: white,
    error: Colors.red,
    onError: white,
    surface: darkGrey,
    onSurface: white,
  );

  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: white,
    secondary: secondary,
    onSecondary: white,
    error: Colors.red,
    onError: white,
    surface: white,
    onSurface: dark,
  );
}

