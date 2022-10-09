import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/app/app.dart';
import 'package:matchfee/coffees/coffees.dart';
import 'package:matchfee/matches/matches.dart';

import '../../helpers/helpers.dart';

void main() {
  group('App', () {
    late MatchesCubit matchesCubit;
    initHydratedStorage();

    setUp(() {
      matchesCubit = buildMatchesCubit(hydratedStorage);
    });
    testWidgets('renders CoffeesPage', (tester) async {
      await tester.pumpApp(
        const App(),
        matchesCubit: matchesCubit,
      );

      expect(find.byType(CoffeesPage), findsOneWidget);
    });
  });
}
