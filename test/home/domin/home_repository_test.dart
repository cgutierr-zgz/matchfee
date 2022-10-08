import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:matchfee/home/home.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Home repository', () {
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

    setUp(initHydratedStorage);

    //* Dont really know how to test this one
    //* since the image is saved to the device
    test(
      'getImageFromDevice should save the image',
      () async {
        const name = 'https://coffee.alexflipnote.dev/9nbUu7WyiFc_coffee.jpg';
        final repository = HomeRepository(client: mockClient);

        // expect(
        //   () => repository.getImageFromDevice(
        //     name,
        //   ),
        //   throwsA(isA<Exception>()),
        // );

        final output = await repository.saveImageToDevice(name);
        expect(output, isA<String>());

        final file = await repository.getImageFromDevice(name);

        expect(file, isA<Uint8List>());
      },
      //skip: true,
    );
  });
}
