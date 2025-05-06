import 'package:beyondmarks/utils/cubit/settings/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingsInit());

  static SettingsCubit get(BuildContext context) => BlocProvider.of(context);
  ThemeMode themeMode = ThemeMode.system;
  String language = 'en';
  bool onboardingDone = false;

  Future<void> changeLanguage(String newLanguage) async {
    emit(ChangeLanguageLoading());
    try {
      if (language == newLanguage) {
        return;
      }
      language = newLanguage;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('language', newLanguage);
      emit(ChangeLanguageSuccess());
    } catch (e) {
      emit(ChangeLanguageError(e.toString()));
    }
  }

  Future<void> changeTheme(ThemeMode newTheme) async {
    emit(ChangeThemeLoading());
    try {
      if (themeMode == newTheme) {
        return;
      }
      themeMode = newTheme;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(
        'theme',
        newTheme == ThemeMode.dark
            ? 'dark'
            : newTheme == ThemeMode.system
                ? 'system'
                : 'light',
      );
      emit(ChangeThemeSuccess());
    } catch (e) {
      emit(ChangeThemeError(e.toString()));
    }
  }
}
