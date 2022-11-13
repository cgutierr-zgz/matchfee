import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:matchfee/repo.dart';
import 'package:mocktail/mocktail.dart';

import 'helpers/helpers.dart';

void main() {
  const url = 'https://coffee.alexflipnote.dev/123.jpg';
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Repo Test', () {
    late CoffeeRepository repo;
    late Client client;

    setUp(() {
      client = MockClient();
      repo = CoffeeRepository(client: client);
      PathProviderPlatform.instance = FakePathProviderPlatform();
    });

    group('getRandomImage', () {
      test('returns an image url when status code is 200', () async {
        when(() => client.get(Uri.parse(CoffeeRepository.baseUrl)))
            .thenAnswer((_) async => Response('{"file": "$url"}', 200));

        final image = await repo.getRandomCoffee();

        expect(image, isA<String>());

        verify(() => client.get(Uri.parse(CoffeeRepository.baseUrl))).called(1);
      });

      test('throws an error when status code is not 200', () async {
        when(() => client.get(Uri.parse(CoffeeRepository.baseUrl)))
            .thenAnswer((_) async => Response('Bad Request', 400));

        final image = repo.getRandomCoffee();

        expect(image, throwsException);
        expect(
          image,
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              'Exception: [400] Failed to load image',
            ),
          ),
        );

        verify(() => client.get(Uri.parse(CoffeeRepository.baseUrl))).called(1);
      });
    });

    group('getImageBytes', () {
      test('returns image bytes from url when status code is 200', () async {
        when(() => client.get(Uri.parse(url)))
            .thenAnswer((_) async => Response('image bytes', 200));

        final image = await repo.getImageBytes(url);

        expect(image, isA<Uint8List>());

        verify(() => client.get(Uri.parse(url))).called(1);
      });

      test('throws an error when status code is not 200', () async {
        when(() => client.get(Uri.parse(url)))
            .thenAnswer((_) async => Response('Bad Request', 400));

        final image = repo.getImageBytes(url);

        expect(image, throwsException);
        expect(
          image,
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              'Exception: [400] Failed to load image',
            ),
          ),
        );

        verify(() => client.get(Uri.parse(url))).called(1);
      });
    });

    test('getAppDirectoryPath returns the app directory path', () async {
      final path = await repo.getAppDirectoryPath();

      expect(path, isA<String>());
      expect(path, 'applicationDocumentsPath');
    });

    test('saveImageToDevice saves an image to device', () async {
/*
      when(() => client.get(Uri.parse(url)))
          .thenAnswer((_) async => Response('image bytes', 200));
      when(() => file.writeAsBytes(any()))
          .thenAnswer((_) async => Future.value(file));

      final image = await repo.saveImageToDevice(url);

      expect(image, isA<File>());
      verify(() => client.get(Uri.parse(url))).called(1);

      verify(() => file.writeAsBytes(any())).called(1);

      verify(() => file.path).called(1);
      */
    });

    test('deleteImage deletes an image from the device', () async {
      /*
      final repo = MockRepo();
      when(() => repo.deleteCoffee(any())).thenAnswer((_) async => true);

      final result = await repo.deleteCoffee('path');

      verify(() => repo.deleteCoffee(any())).called(1);
      */
    });

/*
    group('deleteAllImages', () {
      test('deleteAllImages deletes all images from the device', () async {
        final repo = MockRepo();
        when(repo.deleteAllImages).thenAnswer((_) async => 'path');

        await repo.deleteAllImages();

        verify(repo.deleteAllImages).called(1);
      });
    });

    group('getDeviceImages', () {
      test('getDeviceImages gets all images stored', () async {
        final repo = MockRepo();
        final bytes = Uint8List.fromList([1, 2, 3]);
        when(repo.getDeviceImages).thenAnswer(
          (_) async => [bytes],
        );

        final images = await repo.getDeviceImages();

        expect(images, isA<List<Uint8List>>());
        verify(repo.getDeviceImages).called(1);
      });
    });*/
  });
}
