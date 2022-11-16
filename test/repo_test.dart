import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:matchfee/coffee/coffe.dart';
import 'package:matchfee/repo.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watcher/watcher.dart';

import 'helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Repo Test', () {
    late CoffeeRepository repo;
    late Client client;
    late File file;
    late Directory directory;
    late DirectoryWatcher watcher;

    setUp(() {
      client = MockClient();
      file = MockFile();
      directory = MockDirectory();
      watcher = MockDirectoryWatcher(dirPath);
      repo = CoffeeRepository(
        client: client,
        directoryWatcher: watcher,
      );
      PathProviderPlatform.instance = FakePathProviderPlatform();
    });

    group('getRandomCoffee', () {
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

    test('saveCoffeeToDevice saves an image to device', () async {
      await IOOverrides.runZoned(
        () async {
          when(() => client.get(Uri.parse(url)))
              .thenAnswer((_) async => Response('image bytes', 200));
          when(() => file.writeAsBytes(any()))
              .thenAnswer((_) async => Future.value(File(filePath)));
          when(file.existsSync).thenReturn(true);

          final image = await repo.saveCoffeeToDevice(
            url,
            superLike: false,
          );

          expect(image, isA<File>());

          verify(() => client.get(Uri.parse(url))).called(1);
          verify(() => file.writeAsBytes(any())).called(1);
          expect(file.existsSync(), true);
        },
        createFile: (_) => file,
      );
    });

    test('deleteCoffee deletes an image from the device', () async {
      await IOOverrides.runZoned(
        () async {
          when(file.deleteSync).thenAnswer((_) => Future<void>.value());
          when(file.existsSync).thenReturn(false);

          final coffee = Coffee(
            path: filePath,
            isSuperLike: false,
            bytes: bytes,
          );

          await repo.deleteCoffee(coffee);

          verify(file.deleteSync).called(1);
          expect(file.existsSync(), false);
        },
        createFile: (_) => file,
      );
    });

    test('deleteAllCoffees deletes all images from the device', () async {
      //IOOverrides.global = null;

      await IOOverrides.runZoned(
        () async {
          when(() => directory.path).thenReturn(dirPath);
          when(() => directory.listSync()).thenAnswer((_) => [file]);
          when(file.deleteSync).thenAnswer((_) => Future<void>.value());
          when(file.existsSync).thenReturn(false);

          await repo.deleteAllCoffees();

          verify(() => directory.listSync()).called(1);
          verify(file.deleteSync).called(1);
          expect(file.existsSync(), false);
        },
        createDirectory: (_) => directory,
      );
    });

    group('getDeviceCoffees', () {
      test('gets all images stored', () async {
        await IOOverrides.runZoned(
          () async {
            when(() => directory.path).thenReturn(dirPath);
            when(() => directory.listSync()).thenAnswer((_) => [file]);
            when(directory.existsSync).thenReturn(true);
            when(() => file.path).thenReturn(filePath);
            when(file.readAsBytesSync).thenReturn(bytes);

            final coffees = await repo.getDeviceCoffees().first;

            expect(coffees, isA<List<Coffee>>());
            expect(coffees.length, 1);

            verify(() => directory.listSync()).called(1);
            verify(file.readAsBytesSync).called(1);

            // TODO: Verify that stream emits a list of coffees
          },
          createDirectory: (_) => directory,
          createFile: (_) => file,
        );
      });
    });
  });
}
