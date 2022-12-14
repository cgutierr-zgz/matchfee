import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Widget extensions', () {
    const horizontalSpacer = SizedBox(width: 10);
    testWidgets('Adding padding in a widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: const Text('Carlos').padded(),
          ),
        ),
      );

      expect(find.byType(Padding), findsOneWidget);
    });

    testWidgets('Adding separator in between items', (tester) async {
      const items = <Widget>[Text('a'), Text('b'), Text('c'), Text('d')];
      final result = items.joinWith(horizontalSpacer);

      await tester.pumpWidget(
        MaterialApp(
          home: Column(
            children: result,
          ),
        ),
      );

      expect(result.length, equals(7));
      expect(find.byType(SizedBox), findsNWidgets(3));
    });

    testWidgets('Adding separator on a single widget produces no result',
        (tester) async {
      const items = <Widget>[Text('a')];
      final result = items.joinWith(horizontalSpacer);

      await tester.pumpWidget(
        MaterialApp(
          home: Column(
            children: result,
          ),
        ),
      );

      expect(result.length, equals(1));
      expect(find.byType(SizedBox), findsNothing);
    });
  });

  group('Theme extension', () {
    testWidgets(
      'Theme of context',
      (tester) async {
        // FlutterError.onError = ignoreOverflowErrors;
        final theme = ThemeData(brightness: Brightness.light);
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(brightness: Brightness.dark),
            home: const Scaffold(),
          ),
        );

        // Capture a BuildContext object
        final BuildContext context = tester.element(find.byType(MaterialApp));

        expect(context.theme.brightness, theme.brightness);
      },
    );
  });

  group('Snackbar extensions', () {
    late MatchesCubit matchesCubit;
    initHydratedStorage();

    setUp(() {
      matchesCubit = buildMatchesCubit(hydratedStorage);
    });
    testWidgets(
      'Show snackbar',
      (tester) async {
        const helloSnackBar = 'Hello SnackBar';
        const tapTarget = Key('tap-target');
        await tester.pumpApp(
          Scaffold(
            body: Builder(
              builder: (context) {
                return GestureDetector(
                  key: tapTarget,
                  onTap: () => context.showSnackbar(helloSnackBar),
                  behavior: HitTestBehavior.opaque,
                );
              },
            ),
          ),
          matchesCubit: matchesCubit,
        );
        expect(find.text(helloSnackBar), findsNothing);
        await tester.tap(
          find.byKey(tapTarget),
          // Added to remove unnecesary warning
          warnIfMissed: false,
        );
        expect(find.text(helloSnackBar), findsNothing);
        await tester.pump();
        expect(find.text(helloSnackBar), findsOneWidget);
      },
    );

    testWidgets(
      'Tests the error snackbar and clicks the action button',
      (tester) async {
        const helloSnackBar = 'Hello SnackBar';
        const tapTarget = Key('tap-target');
        await tester.pumpApp(
          Scaffold(
            body: Builder(
              builder: (context) {
                return GestureDetector(
                  key: tapTarget,
                  onTap: () => context.showSnackbar(
                    helloSnackBar,
                    error: true,
                    onPressed: () => debugPrint('henlo'),
                  ),
                  behavior: HitTestBehavior.opaque,
                );
              },
            ),
          ),
          matchesCubit: matchesCubit,
        );
        expect(find.text(helloSnackBar), findsNothing);
        await tester.tap(
          find.byKey(tapTarget),
          // Added to remove unnecesary warning
          warnIfMissed: false,
        );
        expect(find.text(helloSnackBar), findsNothing);
        await tester.pump();
        expect(find.text(helloSnackBar), findsOneWidget);
        expect(find.text('Accept'), findsOneWidget);
        expect(find.byType(TextButton), findsNWidgets(2));

        // dismiss the snackbar
        await tester.press(
          find.byType(TextButton).last,
          // Added to remove unnecesary warning
          warnIfMissed: false,
        );

        await tester.pumpAndSettle(const Duration(seconds: 3));

        /*
        * I don't know how to test dismissed snackbars, even after click
          on the action button, the snackbar is still there
        */
      },
    );
  });
}
