import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:matchfee/profile/profile.dart';

class SettingsCubit extends HydratedCubit<Settings> {
  SettingsCubit() : super(const Settings(themeMode: ThemeMode.system));

  void toggleThemeMode(ThemeMode themeMode) =>
      emit(state.copyWith(themeMode: themeMode));

  @override
  Settings fromJson(Map<String, dynamic> json) => Settings.fromJson(json);

  @override
  Map<String, dynamic> toJson(Settings state) => state.toJson();
}
