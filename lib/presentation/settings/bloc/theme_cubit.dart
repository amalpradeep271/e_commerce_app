import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const _themeKey = 'app_theme_mode';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  ThemeCubit() : super(ThemeMode.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final themeStr = await _storage.read(key: _themeKey);
    if (themeStr != null) {
      if (themeStr == 'dark') {
        emit(ThemeMode.dark);
      } else if (themeStr == 'light') {
        emit(ThemeMode.light);
      } else {
        emit(ThemeMode.system);
      }
    }
  }

  Future<void> updateTheme(ThemeMode themeMode) async {
    emit(themeMode);
    String val = 'light';
    if (themeMode == ThemeMode.dark) {
      val = 'dark';
    } else if (themeMode == ThemeMode.system) {
      val = 'system';
    }
    await _storage.write(key: _themeKey, value: val);
  }
}
