import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/home/home.dart';
import 'package:matchfee/matches/matches.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    required MatchesCubit matchesCubit,
    HomeBloc? homeBloc,
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
        home: RepositoryProvider<HomeRepository>(
          create: (context) => HomeRepository(client: Client()),
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: matchesCubit,
              ),
              if (homeBloc != null)
                BlocProvider.value(
                  value: homeBloc,
                )
              else
                BlocProvider<HomeBloc>(
                  create: (context) => HomeBloc(
                    homeRepository: context.read<HomeRepository>(),
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
