import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/core/core.dart';

void main() {
  const horizontalSpacer = SizedBox(width: 10);
  group('Widget extensions', () {
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

  group('Context extensions', () {
    testWidgets(
      'theme of context',
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
}
