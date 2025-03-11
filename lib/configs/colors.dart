import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1ED760); // Màu chính
  static const Color secondary = Color(0xFFD7BD1E); // Màu phụ
  static const Color neutralWhite = Color(0xFFF0F0F0);
  static const Color neutralBlack = Color(0xFF0F0E0E);
  static const Color neutralGray = Color(0xFF333333);
  static const Color neutralRed = Color(0xFFFF0000);

  static const LinearGradient gradient = LinearGradient(
    colors: [Color(0xFF000000), Color(0xFF333333)],
    stops: [0.0, 1.0],
  );
}
