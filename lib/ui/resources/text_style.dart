import 'package:beyondmarks/utils/cubit/settings/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle font24W500({
  Color? color,
  required SettingsCubit settingsCubit,
}) {
  final isArabic = settingsCubit.language == 'ar';
  final themeMode = settingsCubit.themeMode;
  final brightness = WidgetsBinding.instance.window.platformBrightness;
  final defaultColor = themeMode == ThemeMode.light
      ? Colors.black
      : themeMode == ThemeMode.dark
          ? Colors.white
          : brightness == Brightness.light
              ? Colors.black
              : Colors.white;

  return isArabic
      ? GoogleFonts.cairo(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: color ?? defaultColor,
        )
      : GoogleFonts.ubuntu(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: color ?? defaultColor,
        );
}

TextStyle font20W500({
  Color? color,
  required SettingsCubit settingsCubit,
}) {
  final isArabic = settingsCubit.language == 'ar';
  final themeMode = settingsCubit.themeMode;
  final brightness = WidgetsBinding.instance.window.platformBrightness;
  final defaultColor = themeMode == ThemeMode.light
      ? Colors.black
      : themeMode == ThemeMode.dark
          ? Colors.white
          : brightness == Brightness.light
              ? Colors.black
              : Colors.white;

  return isArabic
      ? GoogleFonts.cairo(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: color ?? defaultColor,
        )
      : GoogleFonts.ubuntu(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: color ?? defaultColor,
        );
}

TextStyle font14W600({
  Color? color,
  required SettingsCubit settingsCubit,
}) {
  final isArabic = settingsCubit.language == 'ar';
  final themeMode = settingsCubit.themeMode;
  final brightness = WidgetsBinding.instance.window.platformBrightness;
  final defaultColor = themeMode == ThemeMode.light
      ? Colors.black
      : themeMode == ThemeMode.dark
          ? Colors.white
          : brightness == Brightness.light
              ? Colors.black
              : Colors.white;

  return isArabic
      ? GoogleFonts.cairo(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: color ?? defaultColor,
        )
      : GoogleFonts.ubuntu(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: color ?? defaultColor,
        );
}
