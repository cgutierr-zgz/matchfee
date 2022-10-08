import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/app/app.dart';
import 'package:matchfee/home/home.dart';
import 'package:matchfee/matches/matches.dart';
import 'package:matchfee/settings/view/settings_page.dart';

import '../../helpers/helpers.dart';

void main() {
  group('HomePage', () {
    late MatchesCubit matchesCubit;
    initHydratedStorage();

    setUp(() {
      matchesCubit = buildMatchesCubit(hydratedStorage);
    });

    testWidgets(
      'Coffees are visible ',
      (tester) async {
        await tester.pumpApp(
          const HomePage(),
          matchesCubit: matchesCubit,
        );

        expect(find.byType(CoffeeCards), findsOneWidget);
        await tester.tap(find.byType(BottomItem).last);
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'Bottom Navbar buttons are visible and the card shows up',
      (tester) async {
        await tester.pumpApp(
          const HomePage(),
          matchesCubit: matchesCubit,
        );

        expect(find.byType(CoffeeCards), findsOneWidget);
        expect(find.byType(BottomItem), findsNWidgets(4));
      },
    );

    testWidgets(
      'Navigates to the matches page',
      (tester) async {
        await tester.pumpApp(
          const App(),
          matchesCubit: matchesCubit,
        );

        expect(find.byIcon(Icons.chat_bubble_rounded), findsOneWidget);
        await tester.tap(find.byIcon(Icons.chat_bubble_rounded));
        await tester.pumpAndSettle();

        expect(find.byType(MatchesPage), findsOneWidget);
      },
    );

    testWidgets(
      'Navigates to the settings page',
      (tester) async {
        await tester.pumpApp(
          const App(),
          matchesCubit: matchesCubit,
        );

        expect(find.byIcon(Icons.settings_rounded), findsOneWidget);
        await tester.tap(find.byIcon(Icons.settings_rounded));
        await tester.pumpAndSettle();

        expect(find.byType(SettingsPage), findsOneWidget);
      },
    );
  });
}
