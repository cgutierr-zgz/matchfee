import 'dart:async';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:matchfee/coffees/coffees.dart';
import 'package:matchfee/matches/matches.dart';
import 'package:path_provider/path_provider.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver();

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Set portrait mode
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      return _setupHydratedBloc(await builder());
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

/// Sets up the hydrated storage for the app and passes over root providers
Future<void> _setupHydratedBloc(Widget child) async {
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  return HydratedBlocOverrides.runZoned(
    () async => runApp(
      RepositoryProvider<CoffeesRepository>(
        create: (context) => CoffeesRepository(
          client: Client(),
        ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<MatchesCubit>(
              create: (_) => MatchesCubit(),
            ),
            BlocProvider<CoffeesBloc>(
              create: (context) => CoffeesBloc(
                coffeesRepository: context.read<CoffeesRepository>(),
                matchesCubit: context.read<MatchesCubit>(),
              ),
            ),
          ],
          child: child,
        ),
      ),
    ),
    storage: storage,
  );
}
