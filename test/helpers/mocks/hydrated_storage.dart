import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:matchfee/matches/matches.dart';
import 'package:mocktail/mocktail.dart';

class MockStorage extends Mock implements Storage {}

MatchesCubit buildMatchesCubit([Storage? storage]) {
  return HydratedBlocOverrides.runZoned(
    MatchesCubit.new,
    storage: storage ?? hydratedStorage, // setUpHydratedStorage(),
  );
}

late Storage hydratedStorage;

void initHydratedStorage() {
  TestWidgetsFlutterBinding.ensureInitialized();
  hydratedStorage = MockStorage();
  when(
    () => hydratedStorage.write(any(), any<dynamic>()),
  ).thenAnswer((_) async {});
  HydratedBlocOverrides.runZoned(() => null, storage: hydratedStorage);
}
