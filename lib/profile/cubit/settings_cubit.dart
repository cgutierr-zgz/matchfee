import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:matchfee/profile/profile.dart';

class SettingsCubit extends HydratedCubit<Settings> {
  SettingsCubit() : super(const Settings(themeMode: ThemeMode.light));

  void toggleThemeMode() => emit(
        state.copyWith(
          themeMode: state.themeMode == ThemeMode.light
              ? ThemeMode.dark
              : ThemeMode.light,
        ),
      );

  @override
  Settings fromJson(Map<String, dynamic> json) => Settings.fromJson(json);

  @override
  Map<String, dynamic> toJson(Settings state) => state.toJson();
}
