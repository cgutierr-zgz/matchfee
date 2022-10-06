import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/app/app.dart';
import 'package:matchfee/home/home.dart';

import '../../helpers/helpers.dart';

void main() {
  group('App', () {
    testWidgets('renders HomePage', (tester) async {
      await tester.pumpApp(const App());

      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
