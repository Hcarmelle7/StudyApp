import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mystudy/tools/themes/colors/app_colors.dart';
import 'package:mystudy/tools/themes/fonts.dart';

IconThemeData customIconTheme(IconThemeData original) {
  return original.copyWith(
    color: AppColors.white2,
  );
}

ThemeData darkTheme() {
  final base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        minimumSize: const Size(120, 40),
        padding: EdgeInsets.zero,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    cardColor: AppColors.darkGrey,  // couleur foncée pour carte
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primary,
      colorScheme: AppColors.darkColorScheme,
      textTheme: ButtonTextTheme.normal,
    ),
    primaryColorLight: AppColors.lightGrey,
    primaryIconTheme: customIconTheme(base.iconTheme),
    textTheme: buildTextTheme(base.textTheme),
    primaryTextTheme: buildTextTheme(base.primaryTextTheme),
    hintColor: AppColors.grey,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground, // foncé
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.darkBackground,
      surfaceTintColor: AppColors.darkGrey,
      titleTextStyle: const TextStyle(
        color: AppColors.white,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      iconTheme: customIconTheme(base.iconTheme).copyWith(
        color: AppColors.white,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: AppColors.darkGrey,
      ),
    ),
  );
}
