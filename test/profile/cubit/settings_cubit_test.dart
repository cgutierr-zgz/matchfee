import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/profile/profile.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('SettingsCubit', () {
    late SettingsCubit cubit;
    setUp(() {
      cubit = MockSettingsCubit();
      when(() => cubit.state).thenReturn(
        const Settings(themeMode: ThemeMode.light),
      );

      setUpSettingsCubit();
    });
    test('initial state theme is light mode', () {
      expect(settingsCubit.state.themeMode, equals(ThemeMode.light));
    });

    group('Toogle themeMode', () {
      blocTest<SettingsCubit, Settings>(
        'updates themeMode to dark',
        build: SettingsCubit.new,
        act: (bloc) {
          bloc.toggleThemeMode();
        },
        expect: () {
          return const [Settings(themeMode: ThemeMode.dark)];
        },
      );

      blocTest<SettingsCubit, Settings>(
        'updates themeMode to light',
        build: SettingsCubit.new,
        act: (bloc) {
          bloc
            ..toggleThemeMode()
            ..toggleThemeMode();
        },
        expect: () {
          return const [
            Settings(themeMode: ThemeMode.dark),
            Settings(themeMode: ThemeMode.light),
          ];
        },
      );

      blocTest<SettingsCubit, Settings>(
        'updates themeMode',
        build: SettingsCubit.new,
        act: (bloc) {
          bloc
            ..toggleThemeMode()
            ..toggleThemeMode()
            ..toggleThemeMode();
        },
        expect: () {
          return const [
            Settings(themeMode: ThemeMode.dark),
            Settings(themeMode: ThemeMode.light),
            Settings(themeMode: ThemeMode.dark),
          ];
        },
      );
    });

    group('json (de)serialization', () {
      test('fromJson converts from json to state', () {
        final result = settingsCubit.fromJson({'themeMode': 1});
        expect(result, const Settings(themeMode: ThemeMode.light));
      });
    });

    test('toJson converts from state to json', () {
      final result = settingsCubit.toJson(
        const Settings(themeMode: ThemeMode.light),
      );
      expect(result, {'themeMode': 1});
    });
  });
}
