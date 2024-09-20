import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void updateTheme(ThemeMode themeMode) => emit(themeMode);

  ThemeMode? fromJson(Map<String, dynamic> json) {
    return ThemeMode.values[json['theme'] as int];
  }

  Map<String, dynamic> toJson(ThemeMode state) {
    return {'theme': state.index};
  }
}

class ThemeState {
  final String name;

  ThemeState(this.name);

  static var light = ThemeState('light');
  static var dark = ThemeState('dark');
}
