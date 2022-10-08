import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:matchfee/app/app.dart';
import 'package:matchfee/home/home.dart';
import 'package:matchfee/matches/matches.dart';
import 'package:matchfee/settings/view/settings_page.dart';

import '../../helpers/helpers.dart';

void main() {
  group('HomePage', () {
    late MatchesCubit matchesCubit;
    late HomeBloc homeBloc;
    initHydratedStorage();

    setUp(() {
      matchesCubit = buildMatchesCubit(hydratedStorage);
      homeBloc = HomeBloc(
        homeRepository: HomeRepository(
          client: Client(),
        ),
        matchesCubit: matchesCubit,
      );
    });
    //* Problems testing this features
    testWidgets(
      'Dislike',
      (tester) async {
        await tester.pumpApp(
          const HomePage(),
          matchesCubit: matchesCubit,
          homeBloc: homeBloc,
        );

        await tester.tap(find.byIcon(Icons.close_rounded));
        await tester.pumpAndSettle();
        // should see next image
      },
    );
    testWidgets(
      'Dislike and Undo',
      (tester) async {
        await tester.pumpApp(
          const HomePage(),
          matchesCubit: matchesCubit,
        );

        await tester.tap(find.byIcon(Icons.close_rounded));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.undo_rounded));
        await tester.pumpAndSettle();
        // should the same image as before
      },
    );

    testWidgets(
      'Like',
      (tester) async {
        await tester.pumpApp(
          const HomePage(),
          matchesCubit: matchesCubit,
        );

        await tester.tap(find.byIcon(Icons.favorite_rounded));
        await tester.pumpAndSettle();
        // should see next image
      },
    );

    testWidgets(
      'Superlike',
      (tester) async {
        await tester.pumpApp(
          const HomePage(),
          matchesCubit: matchesCubit,
          homeBloc: homeBloc,
        );

        await tester.tap(find.byIcon(Icons.star_rounded));
        await tester.pumpAndSettle();
        homeBloc.add(const HomeStartEvent(['image1']));
        await tester.pumpAndSettle();
        // should see a snackbar
        // * problems testing this
        //expect(find.text('I love u too'), findsOneWidget);
      },
    );

    testWidgets(
      'Coffees are visible ',
      (tester) async {
        await tester.pumpApp(
          const HomePage(),
          matchesCubit: matchesCubit,
        );

        expect(find.byType(CoffeeCards), findsOneWidget);
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
