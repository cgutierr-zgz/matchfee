import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:matchfee/coffee/domain/coffee.dart';
import 'package:path_provider/path_provider.dart';

abstract class ICoffeeRepository {
  Future<String> getRandomCoffee();
  Future<Uint8List> getImageBytes(String url);
  Future<File> saveCoffeeToDevice(String url, {required bool superLike});
  Future<void> deleteCoffee(Coffee coffee);
  Future<void> deleteAllCoffees();
  Future<List<Coffee>> getDeviceCoffees();
  Future<String> getAppDirectoryPath();
}

class CoffeeRepository implements ICoffeeRepository {
  CoffeeRepository({required Client client}) : _client = client;

  late final Client _client;
  static const String baseUrl = 'https://coffee.alexflipnote.dev/random.json';

  @override
  Future<String> getRandomCoffee() async {
    final response = await _client.get(Uri.parse(baseUrl));

    if (response.statusCode != 200) {
      throw Exception('[${response.statusCode}] Failed to load image');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final photoUrl = json['file'] as String;

    return photoUrl;
  }

  @override
  Future<Uint8List> getImageBytes(String url) async {
    final response = await _client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('[${response.statusCode}] Failed to load image');
    }

    return response.bodyBytes;
  }

  @override
  Future<String> getAppDirectoryPath() =>
      getApplicationDocumentsDirectory().then((value) => value.path);

  @override
  Future<File> saveCoffeeToDevice(
    String url, {
    required bool superLike,
  }) async {
    final directory = await getAppDirectoryPath();
    final bytes = await getImageBytes(url);
    final name = url.split('/').last.split('.').first;
    final file = File('$directory/${superLike ? 'SUPER-' : ''}$name');

    return file.writeAsBytes(bytes);
  }

  @override
  Future<void> deleteCoffee(Coffee coffee) async =>
      File(coffee.path).deleteSync();

  @override
  Future<void> deleteAllCoffees() async {
    final directory = await getAppDirectoryPath();
    final files = Directory(directory).listSync();

    for (final file in files) {
      file.deleteSync();
    }
  }

  @override
  Future<List<Coffee>> getDeviceCoffees() async {
    final directory = await getAppDirectoryPath();

    final files = Directory(directory).listSync();
    final coffees = <Coffee>[];

    for (final file in files) {
      final bytes = await File(file.path).readAsBytes();

      final coffee = Coffee(
        path: file.path,
        bytes: bytes,
        isSuperLike: file.path.contains('SUPER-'),
      );

      coffees.add(coffee);
    }

    return coffees;
  }
}
