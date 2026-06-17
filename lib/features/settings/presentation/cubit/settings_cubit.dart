import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final Box settingsBox;

  SettingsCubit(this.settingsBox) : super(const SettingsState()) {
    _loadSettings();
  }

  void _loadSettings() {
    final isDarkMode = settingsBox.get('isDarkMode', defaultValue: false);
    final language = settingsBox.get('language', defaultValue: 'English');
    emit(SettingsState(isDarkMode: isDarkMode, language: language));
  }

  void toggleDarkMode(bool value) async {
    await settingsBox.put('isDarkMode', value);
    emit(state.copyWith(isDarkMode: value));
  }

  void setLanguage(String language) async {
    await settingsBox.put('language', language);
    emit(state.copyWith(language: language));
  }
}
