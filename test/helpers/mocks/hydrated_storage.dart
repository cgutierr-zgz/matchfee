import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:matchfee/matches/matches.dart';
import 'package:mocktail/mocktail.dart';

class MockStorage extends Mock implements Storage {}

MockStorage setUpHydratedStorage() {
  final hydratedStorage = MockStorage();

  when(() => hydratedStorage.write(any(), any<dynamic>()))
      .thenAnswer((_) async {});

  when<dynamic>(() => hydratedStorage.read(any())).thenAnswer((_) async {});

  when(() => hydratedStorage.delete(any())).thenAnswer((_) async {});

  return hydratedStorage;
}

MatchesCubit buildMatchesCubit() => HydratedBlocOverrides.runZoned(
      MatchesCubit.new,
      storage: setUpHydratedStorage(),
    );
