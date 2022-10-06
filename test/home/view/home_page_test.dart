import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/app/view/app.dart';
import 'package:matchfee/home/home.dart';
import 'package:matchfee/matches/matches.dart';
import 'package:matchfee/settings/view/settings_page.dart';

import '../../helpers/helpers.dart';

void main() {
  group('HomePage', () {
    testWidgets('Bottom Navbar buttons are visible and the card shows up',
        (tester) async {
      await tester.pumpApp(const App());

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(CoffeeCards), findsOneWidget);
      expect(find.byType(BottomItem), findsNWidgets(4));
    });

    testWidgets('Navigates to the matches page', (tester) async {
      await tester.pumpApp(const App());

      expect(find.byIcon(Icons.chat_bubble_rounded), findsOneWidget);
      await tester.tap(find.byIcon(Icons.chat_bubble_rounded));
      await tester.pumpAndSettle();

      expect(find.byType(MatchesPage), findsOneWidget);
    });

    testWidgets('Navigates to the settings page', (tester) async {
      await tester.pumpApp(const App());

      expect(find.byIcon(Icons.settings_rounded), findsOneWidget);
      await tester.tap(find.byIcon(Icons.settings_rounded));
      await tester.pumpAndSettle();

      expect(find.byType(SettingsPage), findsOneWidget);
    });
  });
}
