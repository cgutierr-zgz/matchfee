import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:matchfee/coffee/domain/coffee.dart';
import 'package:path_provider/path_provider.dart';
import 'package:watcher/watcher.dart';

abstract class ICoffeeRepository {
  Future<String> getRandomCoffee();
  Future<Uint8List> getImageBytes(String url);
  Future<File> saveCoffeeToDevice(String url, {required bool superLike});
  Future<void> deleteCoffee(Coffee coffee);
  Future<void> deleteAllCoffees();
  Stream<List<Coffee>> getDeviceCoffees();
  List<Coffee> getDirectoryUpdates(Directory directory);
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
  Future<File> saveCoffeeToDevice(
    String url, {
    required bool superLike,
  }) async {
    final directory = await getApplicationDocumentsDirectory();
    final bytes = await getImageBytes(url);
    final name = url.split('/').last.split('.').first;
    final file = File(
      '${directory.path}/images/${superLike ? 'SUPER-' : ''}$name',
    );

    return file.writeAsBytes(bytes);
  }

  @override
  Future<void> deleteCoffee(Coffee coffee) async =>
      File(coffee.path).deleteSync();

  @override
  Future<void> deleteAllCoffees() async {
    final appDir = await getApplicationDocumentsDirectory();
    final directory = Directory('${appDir.path}/images');
    final files = directory.listSync();

    for (final file in files) {
      file.deleteSync();
    }
  }

  @override
  Stream<List<Coffee>> getDeviceCoffees() async* {
    final appDir = await getApplicationDocumentsDirectory();
    final directory = Directory('${appDir.path}/images');
    if (!directory.existsSync()) await directory.create();

    final watcher = DirectoryWatcher(directory.path);

    // handles the initial load
    yield getDirectoryUpdates(directory);
    yield* watcher.events.map((_) => getDirectoryUpdates(directory));
  }

  @override
  List<Coffee> getDirectoryUpdates(Directory directory) {
    final files = directory.listSync()
      ..sort((a, b) => b.statSync().changed.compareTo(a.statSync().changed));

    return files.map((f) {
      final path = f.path;
      final bytes = File(path).readAsBytesSync();
      final isSuperLike = path.contains('SUPER-');

      return Coffee(path: path, bytes: bytes, isSuperLike: isSuperLike);
    }).toList();
  }
}
