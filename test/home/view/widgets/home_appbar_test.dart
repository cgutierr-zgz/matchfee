import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/home/home.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('MatchesAppBar', () {
    testWidgets('buttons are visible and interactable', (tester) async {
      await tester.pumpApp(
        BlocProvider(
          create: (_) => buildMatchesCubit(),
          child: const HomeAppBar(),
        ),
      );
      expect(find.byType(IconButton), findsNWidgets(2));

      // Navigates to the settings page
      //await tester.tap(find.byIcon(Icons.settings));
      //await tester.tap(find.byIcon(Icons.chat_bubble));
      // TODO(c): pump and settle -> settings page
      // TODO(c): pump and settle -> matches page
      //    await tester.pumpAndSettle();
      //    expect(find.byType(SettingsPage), findsOneWidget);
      //    expect(find.byType(MatchesPage), findsOneWidget);
    });
  });

/*  group('CounterView', () {
    late MatchesCubit matchesCubit;

    setUp(() {
      matchesCubit = buildMatchesCubit();
    });

    testWidgets('renders current matches list', (tester) async {
      final state = [const SavedCoffee(imagePath: 'image1', superLike: true)];
      matchesCubit.emit(state);

      await tester.pumpApp(
        BlocProvider.value(
          value: matchesCubit,
          child: const MatchesPage(),
        ),
      );
      expect(find.text('state'), findsOneWidget);
    });
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
  });
    */
}
