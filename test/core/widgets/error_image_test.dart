import 'package:flutter_test/flutter_test.dart';
import 'package:matchfee/core/core.dart';

void main() {
  group('Error Image', () {
    testWidgets('Tests error image', (tester) async {
      await tester.pumpWidget(const ErrorImage(height: 100, width: 200));
      expect(find.byType(ErrorImage), findsOneWidget);
      // expect finds a widget with same with and height
      expect(
        find.byWidgetPredicate((widget) {
          if (widget is ErrorImage) {
            return widget.width != widget.height;
          }
          return false;
        }),
        findsOneWidget,
      );
    });

    testWidgets('Tests error image with sqare constructor', (tester) async {
      await tester.pumpWidget(const ErrorImage.square(size: 100));
      expect(find.byType(ErrorImage), findsOneWidget);
      // expect finds a widget with same with and height
      expect(
        find.byWidgetPredicate((widget) {
          if (widget is ErrorImage) {
            return widget.width == widget.height;
          }
          return false;
        }),
        findsOneWidget,
      );
    });
  });
}
