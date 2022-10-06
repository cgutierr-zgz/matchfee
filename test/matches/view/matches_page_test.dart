import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/matches/matches.dart';

import '../../helpers/helpers.dart';

void main() {
  group('MatchesPage', () {
    testWidgets('renders MatchesAppBar', (tester) async {
      await tester.pumpApp(
        const MatchesPage(),
      );
      expect(find.byType(MatchesAppBar), findsOneWidget);
    });
  });
}
