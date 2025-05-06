import 'package:beyondmarks/utils/cubit/settings/settings_cubit.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getFormattedTime(int timestamp, SettingsCubit settingsCubit) {
  final DateTime lastSeen =
      DateTime.fromMillisecondsSinceEpoch(timestamp).toLocal();
  final DateTime now = DateTime.now().toLocal();

  if (lastSeen.year == now.year &&
      lastSeen.month == now.month &&
      lastSeen.day == now.day) {
    return DateFormat('hh:mm a').format(lastSeen);
  }

  final DateTime yesterday = now.subtract(const Duration(days: 1));
  if (lastSeen.year == yesterday.year &&
      lastSeen.month == yesterday.month &&
      lastSeen.day == yesterday.day) {
    return settingsCubit.language == 'en'
        ? 'Yesterday at ${DateFormat('hh:mm a').format(lastSeen)}'
        : 'أمس في ${DateFormat('hh:mm a').format(lastSeen)}';
  }

  if (lastSeen.year == now.year) {
    return settingsCubit.language == 'en'
        ? '${DateFormat('d/M').format(lastSeen)} at ${DateFormat('hh:mm a').format(lastSeen)}'
        : '${DateFormat('d/M').format(lastSeen)} الساعة ${DateFormat('hh:mm a').format(lastSeen)}';
  }

  return settingsCubit.language == 'en'
      ? '${DateFormat('d MMM, yyyy').format(lastSeen)} at ${DateFormat('hh:mm a').format(lastSeen)}'
      : '${DateFormat('d MMM, yyyy').format(lastSeen)} الساعة ${DateFormat('hh:mm a').format(lastSeen)}';
}

String getFormattedDateHeader(int timestamp, SettingsCubit settingsCubit) {
  final DateTime date =
      DateTime.fromMillisecondsSinceEpoch(timestamp).toLocal();
  final DateTime now = DateTime.now().toLocal();

  if (now.year == date.year && now.month == date.month && now.day == date.day) {
    return settingsCubit.language == 'en' ? 'Today' : 'اليوم';
  } else if (now.year == date.year &&
      now.month == date.month &&
      now.day == date.day + 1) {
    return settingsCubit.language == 'en' ? 'Yesterday' : 'أمس';
  } else {
    return DateFormat('dd MMM yyyy').format(date);
  }
}

bool containsLink(String message) {
  final RegExp urlPattern = RegExp(
    r'(?:(?:https?|ftp)://)?(?:[\w-]+\.)+[a-z]{2,}(?:/[\w-./?%&=]*)?',
    caseSensitive: false,
  );
  return urlPattern.hasMatch(message);
}

bool isArabic(String text) {
  return RegExp(r'^[\u0600-\u06FF]+').hasMatch(text);
}

Future<void> getPreferences(SettingsCubit settingsCubit) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? language = prefs.getString('language');
  settingsCubit.changeLanguage(language ?? 'en');

  final String? theme = prefs.getString('theme');
  ThemeMode themeMode = ThemeMode.system;
  if (theme == 'dark') themeMode = ThemeMode.dark;
  if (theme == 'light') themeMode = ThemeMode.light;
  settingsCubit.changeTheme(themeMode);

  settingsCubit.onboardingDone = prefs.getBool('onboarding_done') ?? false;
}

bool isOutdatedVersion(String currentVersion, String requiredVersion) {
  final List<int> current = currentVersion.split('.').map(int.parse).toList();
  final List<int> required = requiredVersion.split('.').map(int.parse).toList();

  for (int i = 0; i < required.length; i++) {
    if (current.length <= i || current[i] < required[i]) {
      return true;
    } else if (current[i] > required[i]) {
      return false;
    }
  }
  return false;
}
