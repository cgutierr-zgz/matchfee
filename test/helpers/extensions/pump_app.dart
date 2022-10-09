import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:matchfee/coffees/coffees.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    required MatchesCubit matchesCubit,
    CoffeesBloc? coffeesBloc,
    Client? client,
  }) {
    return pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: RepositoryProvider<CoffeesRepository>(
          create: (context) => CoffeesRepository(client: client ?? Client()),
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: matchesCubit,
              ),
              if (coffeesBloc != null)
                BlocProvider<CoffeesBloc>.value(
                  value: coffeesBloc,
                )
              else
                BlocProvider<CoffeesBloc>(
                  create: (context) => CoffeesBloc(
                    coffeesRepository: context.read<CoffeesRepository>(),
                    matchesCubit: context.read<MatchesCubit>(),
                  ),
                ),
            ],
            child: widget,
          ),
        ),
      ),
    );
  }
}
