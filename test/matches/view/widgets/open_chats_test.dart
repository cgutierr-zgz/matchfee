import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/matches/matches.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('Open chats', () {
    testWidgets('renders the list correctly', (tester) async {
      const list = [
        SavedCoffee(imagePath: '1', superLike: true),
        SavedCoffee(imagePath: '2', superLike: false),
        SavedCoffee(imagePath: '3', superLike: true),
        SavedCoffee(imagePath: '4', superLike: false),
        SavedCoffee(imagePath: '5', superLike: false),
        SavedCoffee(imagePath: '6', superLike: false),
        SavedCoffee(imagePath: '7', superLike: true),
      ];
      await tester.pumpApp(
        const Scaffold(
          body: CustomScrollView(
            slivers: [
              OpenChats(
                coffees: list,
              )
            ],
          ),
        ),
      );

      // ❗️Important:
      // Finds 5 because we have this condition:
      // if (index.isEven && index % 3 == 0) {
      expect(find.byType(CoffeeAvatar), findsNWidgets(5));
      // And the same applies for the star
      expect(find.byIcon(Icons.star_rounded), findsNWidgets(1));
      // CoffeeAvatar is the only single widget inside each OpenChat Row
    });
  });
}
