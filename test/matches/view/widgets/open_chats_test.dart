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
      const text = 'Hi Im carlito';
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

      // Finds 6 because we have this condition:
      // if (index.isEven && index % 4 == 0 && index % 5 == 0) {
      expect(find.byType(CoffeeAvatar), findsNWidgets(6));
      // CoffeeAvatar is the only single widget inside each OpenChat Row
    });
  });
}
