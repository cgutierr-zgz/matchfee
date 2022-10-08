import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/matches/matches.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('Info tile', () {
    late MatchesCubit matchesCubit;
    initHydratedStorage();

    setUp(() {
      matchesCubit = buildMatchesCubit(hydratedStorage);
    });
    testWidgets('Renders the given text correctly', (tester) async {
      const text = 'Hi Im carlito';
      await tester.pumpApp(
        const Scaffold(
          body: CustomScrollView(
            slivers: [InfoTitle(text: text)],
          ),
        ),
        matchesCubit: matchesCubit,
      );

      expect(find.byType(SliverToBoxAdapter), findsOneWidget);
      expect(find.text(text), findsOneWidget);
    });
  });
}
