import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/profile/profile.dart';

import '../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Matchfee App', () {
    setUp(() {
      // HttpOverrides.runZoned(
      //   () {},
      //   createHttpClient: (securityContext) => MockHttpClient(securityContext),
      // );
      HttpOverrides.global = null;
    });
    testWidgets('renders ProfilePage', (tester) async {
      await tester.pumpApp(const ProfilePage());

      expect(find.byType(ProfilePage), findsOneWidget);
    });

    testWidgets('shows new themeMode when cubit is updated', (tester) async {
      await tester.pumpApp(const ProfilePage());

      expect(find.text('Profile Page'), findsOneWidget);
      expect(
        find.widgetWithIcon(ThemeToogler, Icons.dark_mode),
        findsOneWidget,
      );
      expect(
        find.widgetWithIcon(ThemeToogler, Icons.light_mode),
        findsNothing,
      );

      settingsCubit.toggleThemeMode();
      await tester.pumpAndSettle();

      expect(
        find.widgetWithIcon(ThemeToogler, Icons.light_mode),
        findsOneWidget,
      );
      expect(
        find.widgetWithIcon(ThemeToogler, Icons.dark_mode),
        findsNothing,
      );

      await tester.tap(find.widgetWithIcon(ThemeToogler, Icons.light_mode));
      await tester.pumpAndSettle();

      expect(
        find.widgetWithIcon(ThemeToogler, Icons.dark_mode),
        findsOneWidget,
      );
      expect(
        find.widgetWithIcon(ThemeToogler, Icons.light_mode),
        findsNothing,
      );
    });
  });
}
