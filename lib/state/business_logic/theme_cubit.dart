import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
    ThemeCubit()
        : super(ThemeState(themeMode: ThemeMode.dark, isDarkTheme: true));

    void toggleAPPtheme() {
        //AppTheme.setStatusBarAndNavigationBarColor(themeMode);

        if (state.themeMode == ThemeMode.dark) {
            emit(ThemeState(
                themeMode: ThemeMode.light,
                isDarkTheme: false,
            ));
        } else {
            emit(ThemeState(
                themeMode: ThemeMode.dark,
                isDarkTheme: true,
            ));
        }

        // for get the syatem thememode
        // final Brightness currentBrihtness =
        //     SchedulerBinding.instance!.window.platformBrightness;

        // currentBrihtness == Brightness.light
        //     ? _setThem(ThemeMode.light)
        //     : _setThem(ThemeMode.dark);
    }

// void _setThem(ThemeMode themeMode) {
//   AppTheme.setStatusBarAndNavigationBarColor(themeMode);
//   emit(ThemeState(themeMode: themeMode));
// }
}
