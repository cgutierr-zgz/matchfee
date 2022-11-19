import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honey/honey.dart';
import 'package:http/http.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:matchfee/app/app.dart';
import 'package:matchfee/matches/cubit/matches_cubit.dart';
import 'package:matchfee/profile/cubit/settings_cubit.dart';
import 'package:matchfee/repo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:watcher/watcher.dart';

const kIsHoney = bool.fromEnvironment('HONEY');

void main() async {
  if (kIsHoney) HoneyWidgetsBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  final appDirectory = await getApplicationDocumentsDirectory();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: appDirectory,
  );

  final client = Client();
  final directoryWatcher = DirectoryWatcher(
    appDirectory.path,
    pollingDelay: const Duration(milliseconds: 200),
  );

  runApp(
    RepositoryProvider(
      create: (_) => CoffeeRepository(
        client: client,
        directoryWatcher: directoryWatcher,
      ),
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
