part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool isDarkMode;
  final String language;

  const SettingsState({
    this.isDarkMode = false,
    this.language = 'English',
  });

  SettingsState copyWith({
    bool? isDarkMode,
    String? language,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      language: language ?? this.language,
    );
  }

  @override
  List<Object> get props => [isDarkMode, language];
}
