import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mystudy/core/themes/colors/app_colors.dart';
import 'package:mystudy/core/themes/fonts.dart';

IconThemeData customIconTheme(IconThemeData original) {
  return original.copyWith(
    color: AppColors.white2,
  );
}

ThemeData lightTheme() {
  final base = ThemeData.light(useMaterial3: true).copyWith(
    snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        minimumSize: const Size(120, 40),
        padding: EdgeInsets.zero,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    ),
  );
  return base.copyWith(
    brightness: Brightness.light,
    cardColor: AppColors.white,
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primary,
      colorScheme: AppColors.lightColorScheme,
      textTheme: ButtonTextTheme.normal,
    ),
    primaryColorLight: AppColors.lightGrey,
    primaryIconTheme: customIconTheme(base.iconTheme).copyWith(
      color: AppColors.white,
    ),
    textTheme: buildTextTheme(base.textTheme),
    primaryTextTheme: buildTextTheme(base.primaryTextTheme),
    hintColor: AppColors.grey,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white2,
      titleTextStyle: const TextStyle(
        color: AppColors.dark,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      iconTheme: customIconTheme(base.iconTheme).copyWith(
        color: AppColors.dark,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarDividerColor: AppColors.white),
    ),
  );
}
