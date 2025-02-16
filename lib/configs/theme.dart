import 'package:flutter/material.dart';
import 'package:sound_mp3/configs/colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.neutralBlack,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.neutralBlack,
          iconTheme: IconThemeData(
            color: AppColors.neutralWhite,
          ),
          centerTitle: true,
        ));
  }
}
