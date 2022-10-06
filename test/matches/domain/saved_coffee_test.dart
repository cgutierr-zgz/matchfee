import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:matchfee/matches/matches.dart';

void main() {
  const coffeeSample = SavedCoffee(
    imagePath: 'coffee2.png',
    superLike: true,
  );

  group('Coffe class tests', () {
    test('fromJson', () {
      final json = jsonEncode({
        'imagePath': 'coffee2.png',
        'superLike': true,
      });

      final result = SavedCoffee.fromJson(json);
      expect(result, equals(coffeeSample));
    });
  });
}
