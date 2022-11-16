import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/matches/matches.dart';
import 'package:matchfee/profile/profile.dart';
import 'package:matchfee/repo.dart';

import 'mocks.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    SettingsCubit? sCubit,
    MatchesCubit? mCubit,
  }) {
    if (sCubit == null) setUpSettingsCubit();
    if (mCubit == null) setUpMatchesCubit();

    final client = MockClient();
    final watcher = MockDirectoryWatcher(dirPath);

    return pumpWidget(
      RepositoryProvider(
        create: (_) => CoffeeRepository(
          client: client,
          directoryWatcher: watcher,
        ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: sCubit ?? settingsCubit),
            BlocProvider.value(value: mCubit ?? matchesCubit),
          ],
          child: MaterialApp(home: widget),
        ),
      ),
    );
  }
}
