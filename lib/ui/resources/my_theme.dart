import 'package:beyondmarks/ui/resources/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  iconTheme: const IconThemeData(
    size: 30,
    color: AppColors.primary,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black87),
    titleLarge: TextStyle(color: Colors.black),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.iconColor,
    foregroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 25,
    ),
    toolbarHeight: 50,
    elevation: 0,
    centerTitle: false,
  ),
);


ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.dark,
  iconTheme: const IconThemeData(
    size: 30,
    color: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white70),
    titleLarge: TextStyle(color: Colors.white),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.iconColor,
    foregroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 25,
    ),
    toolbarHeight: 50,
    elevation: 0,
    centerTitle: false,
  ),
);

