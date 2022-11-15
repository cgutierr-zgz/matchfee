import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/profile/profile.dart';

import '../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Matchfee App', () {
    setUp(() {
      HttpOverrides.global = null;
    });
    testWidgets('renders ProfilePage', (tester) async {
      await tester.pumpApp(const ProfilePage());

      expect(find.byType(ProfilePage), findsOneWidget);
    });

    testWidgets('shows new themeMode when cubit is updated', (tester) async {
      await tester.pumpApp(const ProfilePage());

      expect(
        find.widgetWithIcon(ThemeToogler, Icons.dark_mode_rounded),
        findsOneWidget,
      );
      expect(
        find.widgetWithIcon(ThemeToogler, Icons.light_mode_rounded),
        findsNothing,
      );

      settingsCubit.toggleThemeMode();
      await tester.pumpAndSettle();

      expect(
        find.widgetWithIcon(ThemeToogler, Icons.light_mode_rounded),
        findsOneWidget,
      );
      expect(
        find.widgetWithIcon(ThemeToogler, Icons.dark_mode_rounded),
        findsNothing,
      );

      await tester
          .tap(find.widgetWithIcon(ThemeToogler, Icons.light_mode_rounded));
      await tester.pumpAndSettle();

      expect(
        find.widgetWithIcon(ThemeToogler, Icons.dark_mode_rounded),
        findsOneWidget,
      );
      expect(
        find.widgetWithIcon(ThemeToogler, Icons.light_mode_rounded),
        findsNothing,
      );
    });
  });
}
