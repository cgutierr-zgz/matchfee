import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/home/home.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('Coffee Cards', () {
    late HomeBloc homeBloc;
    initHydratedStorage();

    setUp(() {
      homeBloc = HomeBloc(
        matchesCubit: buildMatchesCubit(),
        homeRepository: HomeRepository(
          client: mockClient,
        ),
      );
    });
    testWidgets(
      'Renders the list of cards',
      (tester) async {
        await tester.pumpWidget(
          BlocProvider(
            create: (context) => homeBloc,
            child: const MaterialApp(
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              home: Scaffold(
                body: SizedBox.square(
                  dimension: 500,
                  child: CoffeeCards(),
                ),
              ),
            ),
          ),
        );

        homeBloc.add(const HomeStartEvent(['test, test, test', 'test']));

        await tester.pumpAndSettle();

        // expect(find.byType(FontCoffeeCard), findsOneWidget);
      },
    );
  });
}
