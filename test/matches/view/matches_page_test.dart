import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';

import '../../helpers/helpers.dart';

void main() {
  group('MatchesPage', () {
    late MatchesCubit matchesCubit;
    initHydratedStorage();

    setUp(() {
      matchesCubit = buildMatchesCubit(hydratedStorage);
    });

    testWidgets('page has text visible and can tap on the Carlos Widget',
        (tester) async {
      await tester.pumpApp(const MatchesPage(), matchesCubit: matchesCubit);
      expect(find.byType(MatchesAppBar), findsOneWidget);
      expect(find.byType(ErrorImage), findsOneWidget);
      matchesCubit.addMatch('', isSuperLike: true);
      await tester.pumpAndSettle();
      expect(find.byType(CoffeeAvatar), findsOneWidget);
      matchesCubit
        ..addMatch('', isSuperLike: true)
        ..addMatch('', isSuperLike: true);
      await tester.pumpAndSettle();
      // the ones in the list and the one in the appbar
      expect(find.byType(CoffeeAvatar), findsNWidgets(5));
      expect(find.byType(InfoTitle), findsNWidgets(2));
      expect(find.byType(OpenChats), findsOneWidget);
    });
  });
}
