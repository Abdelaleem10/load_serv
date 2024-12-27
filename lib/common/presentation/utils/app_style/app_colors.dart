import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color orangeColor = Color(0xFFFE962D);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grayColor = Color(0xFF676666);
  static const Color binkColor = Color(0xFFFF6060);
  static const Gradient iconGradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.centerLeft,
      colors: [
        white,
        orangeColor,
        // orangeColor,
        // Color(0xFFD24141),
        Colors.red,
      ]);
}
