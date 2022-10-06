import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/settings/view/settings_page.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Settings Page', () {
    testWidgets('page has text visible and can tap on the Carlos Widget',
        (tester) async {
      await tester.pumpApp(const SettingsPage());

      expect(find.byType(Text), findsNWidgets(5));
      expect(find.text('Carlos'), findsOneWidget);
      expect(find.text('💙'), findsOneWidget);
      await tester.tap(find.text('💙'), warnIfMissed: false);
      await tester.pump();
      expect(find.text('🦄'), findsOneWidget);
    });
  });
}
