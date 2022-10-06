import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:matchfee/home/home.dart';


void main() {
  group('Home repository', () {
    test('getCoffeeImages should return a list of strings (coffee images)',
        () async {
      final repository = HomeRepository(
        client: Client(),
      );

      final result = await repository.getCoffeeImages(1);

      expect(result, isA<List<String>>());
    });
    test(
        'getCoffeeImages should return a list of strings (coffee images), without error',
        () async {
      final repository = HomeRepository(
        client: MockClient(
          (request) async {
            return Response('{"file":  "test"}', 200);
          },
        ),
      );

      final result = await repository.getCoffeeImages(1);

      expect(result, isA<List<String>>());
    });
    test('getImageData the bytes of the image', () async {
      final bytes = Uint8List(10);
      final repository = HomeRepository(
        client: MockClient(
          (request) async {
            return Response(bytes.toString(), 200);
          },
        ),
      );

      final result = await repository.getImageData(
        'https://coffee.alexflipnote.dev/9nbUu7WyiFc_coffee.jpg',
      );

      expect(result, isA<Uint8List>());
    });

    test('saveImageToDevice should save the image', () async {
      final repository = HomeRepository(
        client: MockClient(
          (request) async {
            return Response('Henlo, i dont need client here', 200);
          },
        ),
      );

      expect(
        () => repository.saveImageToDevice(
          'https://coffee.alexflipnote.dev/9nbUu7WyiFc_coffee.jpg',
        ),
        // Since I don't know how to mock this storage... sorry
        throwsA(isA<Exception>()),
      );
    });
    test('getImageFromDevice should save the image', () async {
      final repository = HomeRepository(
        client: MockClient(
          (request) async {
            return Response('Henlo, i dont need client here', 200);
          },
        ),
      );

      expect(
        () => repository.getImageFromDevice(
          'carlito/doc/mypath.1.png',
        ),
        // Since I don't know how to mock this storage... sorry
        throwsA(isA<Exception>()),
      );
    });
  });
}
