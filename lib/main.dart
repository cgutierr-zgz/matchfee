import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:matchfee/app/app.dart';
import 'package:matchfee/matches/cubit/matches_cubit.dart';
import 'package:matchfee/profile/cubit/settings_cubit.dart';
import 'package:matchfee/repo.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  final client = Client();

  runApp(
    RepositoryProvider(
      create: (_) => CoffeeRepository(client: client),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => SettingsCubit(),
          ),
          BlocProvider(
            create: (context) => MatchesCubit(
              coffeeRepository: context.read<CoffeeRepository>(),
            ),
          ),
        ],
        child: const Matchfee(),
      ),
    ),
  );
}
