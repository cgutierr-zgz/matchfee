import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/matches/matches.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('Coffee Avatar', () {
    testWidgets('Renders coffe avatar', (tester) async {
      await tester.pumpApp(
        const CoffeeAvatar(
          imagePath: 'image1.png',
        ),
      );

      expect(find.byType(GestureDetector), findsOneWidget);
      await tester.tap(find.byIcon(Icons.delete));

      /*
      * Dont know how to test the Opacity of a widget
      * Here the trash icon is rendered with an opacity of 1 after the tap
      */
    });
  });
}
