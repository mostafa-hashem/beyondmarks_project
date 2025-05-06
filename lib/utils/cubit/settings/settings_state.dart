abstract class SettingsStates {}

class SettingsInit extends SettingsStates {}

class ChangeThemeLoading extends SettingsStates {}

class ChangeThemeSuccess extends SettingsStates {}

class ChangeThemeError extends SettingsStates {
  final String message;

  ChangeThemeError(this.message);
}

class ChangeLanguageLoading extends SettingsStates {}

class ChangeLanguageSuccess extends SettingsStates {}

class ChangeLanguageError extends SettingsStates {
  final String message;

  ChangeLanguageError(this.message);
}
