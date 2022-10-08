import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/matches/matches.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('Recent chats', () {
    late MatchesCubit matchesCubit;
    initHydratedStorage();

    setUp(() {
      matchesCubit = buildMatchesCubit(hydratedStorage);
    });

    testWidgets('renders the entire list', (tester) async {
      const list = [
        SavedCoffee(imagePath: '1', superLike: true),
      ];

      await tester.pumpApp(
        const Scaffold(
          body: CustomScrollView(
            slivers: [RecentMatchesRow(coffees: list)],
          ),
        ),
        matchesCubit: matchesCubit,
      );

      expect(find.byType(CoffeeAvatar), findsNWidgets(list.length));
      // CoffeeAvatar is the only single widget inside each OpenChat Row
    });

    testWidgets('renders the entire list', (tester) async {
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
            slivers: [RecentMatchesRow(coffees: list)],
          ),
        ),
        matchesCubit: matchesCubit,
      );

      expect(find.byType(CoffeeAvatar), findsNWidgets(list.length));
      // CoffeeAvatar is the only single widget inside each OpenChat Row
      expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
      // Finds only one, since this icon only appears in the first item in
      // the row, it the size of the list is greater than 2
    });
  });
}
