import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/core/core.dart';

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

    group('joinWith', () {
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
  });

  group('Context extensions', () {
    testWidgets(
      'Theme of context',
      (tester) async {
        final theme = ThemeData(brightness: Brightness.light);
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(brightness: Brightness.dark),
            home: const Scaffold(),
          ),
        );

        final BuildContext context = tester.element(find.byType(MaterialApp));

        expect(context.theme.brightness, theme.brightness);
      },
    );

    testWidgets(
      'Navigator push',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold()),
        );

        // Capture a BuildContext object
        final BuildContext context = tester.element(find.byType(Scaffold));

        // ignore: cascade_invocations
        context.push(const Text('Carlos'));

        await tester.pumpAndSettle();

        expect(find.text('Carlos'), findsOneWidget);
      },
    );
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
}
