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
        const Settings(themeMode: ThemeMode.system),
      );

      setUpSettingsCubit();
    });
    test('initial state theme is system mode', () {
      expect(settingsCubit.state.themeMode, equals(ThemeMode.system));
    });

    group('Toogle themeMode', () {
      blocTest<SettingsCubit, Settings>(
        'updates themeMode to dark',
        build: SettingsCubit.new,
        act: (bloc) {
          bloc.toggleThemeMode(ThemeMode.dark);
        },
        expect: () {
          return const [Settings(themeMode: ThemeMode.dark)];
        },
      );

      blocTest<SettingsCubit, Settings>(
        'updates themeMode to light',
        build: SettingsCubit.new,
        act: (bloc) {
          bloc.toggleThemeMode(ThemeMode.light);
        },
        expect: () {
          return const [Settings(themeMode: ThemeMode.light)];
        },
      );

      blocTest<SettingsCubit, Settings>(
        'updates themeMode',
        build: SettingsCubit.new,
        act: (bloc) {
          bloc
            ..toggleThemeMode(ThemeMode.dark)
            ..toggleThemeMode(ThemeMode.light)
            ..toggleThemeMode(ThemeMode.system);
        },
        expect: () {
          return const [
            Settings(themeMode: ThemeMode.dark),
            Settings(themeMode: ThemeMode.light),
            Settings(themeMode: ThemeMode.system),
          ];
        },
      );
    });

    group('json (de)serialization', () {
      test('fromJson converts from json to state', () {
        final result = settingsCubit.fromJson({'themeMode': 0});
        expect(result, const Settings(themeMode: ThemeMode.system));
      });
    });

    test('toJson converts from state to json', () {
      final result = settingsCubit.toJson(
        const Settings(themeMode: ThemeMode.system),
      );
      expect(result, {'themeMode': 0});
    });
  });
}
