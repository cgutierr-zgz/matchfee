// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:matchfee/matches/matches.dart';
import 'package:matchfee/profile/profile.dart';
import 'package:matchfee/repo.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:watcher/watcher.dart';

export 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class FakePathProviderPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async =>
      'applicationDocumentsPath';
}

class MockClient extends Mock implements Client {}

class MockFile extends Mock implements File {}

class MockDirectory extends Mock implements Directory {}

class MockStorage extends Mock implements Storage {}

class MockSettingsCubit extends MockCubit<Settings> implements SettingsCubit {}

late Storage storage;
late SettingsCubit settingsCubit;
late MatchesCubit matchesCubit;

void _setUpStorage() {
  storage = MockStorage();
  when(() => storage.write(any(), any() as dynamic)).thenAnswer(
    (_) async {},
  );
  HydratedBloc.storage = storage;
}

void setUpSettingsCubit() {
  _setUpStorage();
  settingsCubit = SettingsCubit();
}

void setUpMatchesCubit() {
  matchesCubit = MatchesCubit(
    coffeeRepository: CoffeeRepository(
      client: MockClient(),
      directoryWatcher: MockDirectoryWatcher(dirPath),
    ),
  );
}

class MockDirectoryWatcher extends Mock implements DirectoryWatcher {
  MockDirectoryWatcher(this.path);

  @override
  final String path;
}

const url = 'https://coffee.alexflipnote.dev/123.jpg';
const filePath = 'path/to/file';
const dirPath = 'path/to/dir';
final bytes = Uint8List.fromList([1, 2, 3]);
