import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/matches/matches.dart';
import 'package:matchfee/settings/view/settings_page.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Settings Page', () {
    late MatchesCubit matchesCubit;
    initHydratedStorage();

    setUp(() {
      matchesCubit = buildMatchesCubit(hydratedStorage);
    });

    testWidgets('page has text visible and can tap on the Carlos Widget',
        (tester) async {
      await tester.pumpApp(const SettingsPage(), matchesCubit: matchesCubit);

      expect(find.byType(Text), findsNWidgets(5));
      expect(find.text('Carlos'), findsOneWidget);
      expect(find.text('💙'), findsOneWidget);
      await tester.tap(find.text('💙'), warnIfMissed: false);
      await tester.pump();
      expect(find.text('🦄'), findsOneWidget);

      expect(find.text('Wipe data'), findsNothing);
      matchesCubit.addMatch('match', isSuperLike: true);
      await tester.pumpAndSettle();
      expect(find.text('Wipe data'), findsOneWidget);
      await tester.tap(find.text('Wipe data'));
      await tester.pumpAndSettle();
      // We cancel the snackbar and open again
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Wipe data'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Accept'));
      await tester.pumpAndSettle();

      expect(find.text('Wipe data'), findsNothing);
    });
  });
}
