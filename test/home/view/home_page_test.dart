import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/home/home.dart';
import 'package:matchfee/matches/matches.dart';

import '../../helpers/helpers.dart';

void main() {
  group('MatchesAppBar', () {
    late MatchesCubit matchesCubit;

    setUp(() {
      matchesCubit = buildMatchesCubit();
    });

    testWidgets('buttons are visible and interactable', (tester) async {
      await tester.pumpApp(
        BlocProvider(
          create: (_) => matchesCubit,
          child: const HomePage(),
        ),
      );

      expect(find.byType(CoffeeCards), findsOneWidget);
      expect(find.byType(BottomItem), findsNWidgets(4));
    });
  });
}
