import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/matches/matches.dart';

import '../../helpers/helpers.dart';

void main() {
  group('MatchesPage', () {
    testWidgets('renders MatchesAppBar', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: buildMatchesCubit(),
          child: const MatchesPage(),
        ),
      );
      expect(find.byType(MatchesAppBar), findsOneWidget);
    });
  });

  group('CounterView', () {
    late MatchesCubit matchesCubit;

    setUp(() {
      matchesCubit = buildMatchesCubit();
    });

    testWidgets('renders current matches list', (tester) async {
      final state = ['1', '2', '3'];
      matchesCubit.emit(state);

      await tester.pumpApp(
        BlocProvider.value(
          value: matchesCubit,
          child: const MatchesPage(),
        ),
      );
      expect(find.text('state'), findsOneWidget);
    });
/*
    testWidgets('calls increment when increment button is tapped',
        (tester) async {
      when(() => counterCubit.state).thenReturn(0);
      when(() => counterCubit.increment()).thenReturn(null);
      await tester.pumpApp(
        BlocProvider.value(
          value: counterCubit,
          child: const CounterView(),
        ),
      );
      await tester.tap(find.byIcon(Icons.add));
      verify(() => counterCubit.increment()).called(1);
    });

    testWidgets('calls decrement when decrement button is tapped',
        (tester) async {
      when(() => counterCubit.state).thenReturn(0);
      when(() => counterCubit.decrement()).thenReturn(null);
      await tester.pumpApp(
        BlocProvider.value(
          value: counterCubit,
          child: const CounterView(),
        ),
      );
      await tester.tap(find.byIcon(Icons.remove));
      verify(() => counterCubit.decrement()).called(1);
    });
    */
  });
}
