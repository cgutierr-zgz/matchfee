import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/app/app.dart';
import 'package:matchfee/home/home.dart';

import '../../helpers/helpers.dart';

void main() {
  group('App', () {
    testWidgets('renders HomePage', (tester) async {
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => buildMatchesCubit(),
          child: const App(),
        ),
      );
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
