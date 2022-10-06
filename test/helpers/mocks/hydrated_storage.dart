import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:matchfee/matches/matches.dart';
import 'package:mocktail/mocktail.dart';

class MockStorage extends Mock implements Storage {}

MockStorage setUpHydratedStorage() {
  final storage = MockStorage();

  when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
  when<dynamic>(() => storage.read(any())).thenReturn(<String, dynamic>{});
  when(() => storage.delete(any())).thenAnswer((_) async {});
  when(storage.clear).thenAnswer((_) async {});

  return storage;
}

MatchesCubit buildMatchesCubit([Storage? storage]) =>
    HydratedBlocOverrides.runZoned(
      MatchesCubit.new,
      storage: storage ?? setUpHydratedStorage(),
    );
