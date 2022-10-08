import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/matches/matches.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('Coffee Avatar', () {
    late MatchesCubit matchesCubit;
    initHydratedStorage();

    setUp(() {
      matchesCubit = buildMatchesCubit(hydratedStorage);
    });

    testWidgets('Renders coffe avatar', (tester) async {
      await tester.pumpApp(
        const CoffeeAvatar(
          imagePath: 'image1.png',
        ),
        matchesCubit: matchesCubit,
      );

      expect(find.byType(GestureDetector), findsOneWidget);
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      /*
      * Dont know how to test the Opacity of a widget
      * Here the trash icon is rendered with an opacity of 1 after the tap
      */
    });
  });
}
