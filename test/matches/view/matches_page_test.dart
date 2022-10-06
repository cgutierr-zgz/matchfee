import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';

import '../../helpers/helpers.dart';

void main() {
  group('MatchesPage', () {
    testWidgets('Renders MatchesAppBar', (tester) async {
      await tester.pumpApp(
        const MatchesPage(),
      );

      expect(find.byType(MatchesAppBar), findsOneWidget);
      expect(find.byType(ErrorImage), findsOneWidget);
    });

    /*
    * Can't test the body of the MatchesPage because
    * of the hydrated cubit storage
    */
  });
}
