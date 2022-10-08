import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:matchfee/home/home.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Home repository', () {
    test(
      'getCoffeeImages should return a list of strings',
      () async {
        final repository = HomeRepository(
          client: Client(),
        );

        final result = await repository.getCoffeeImages(1);

        expect(result, isA<List<String>>());
        expect(result.length, 1);
      },
      //skip: true,
    );

    test(
      'getCoffeeImages should return a list of strings, without error',
      () async {
        final repository = HomeRepository(client: mockClient);

        final result = await repository.getCoffeeImages(5);

        expect(result, isA<List<String>>());
        expect(result.length, 5);
      },
      //skip: true,
    );

    test(
      'getImageData the bytes of the image',
      () async {
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
      },
      //skip: true,
    );

    /*
  * This two functions are not really well tested
  * Since I don't know how to mock this storage
  * to receive and store the data
  */
    test(
      'saveImageToDevice should save the image',
      () async {
        final repository = HomeRepository(client: mockClient);

        expect(
          () => repository.saveImageToDevice(
            'https://coffee.alexflipnote.dev/9nbUu7WyiFc_coffee.jpg',
          ),
          throwsA(isA<Exception>()),
        );
      },
      //skip: true,
    );

    test(
      'getImageFromDevice should save the image',
      () async {
        final repository = HomeRepository(client: mockClient);

        expect(
          () => repository.getImageFromDevice(
            'carlito/doc/mypath.1.png',
          ),
          throwsA(isA<Exception>()),
        );
      },
      //skip: true,
    );
  });
}
