import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class CoffeesRepository {
  CoffeesRepository({required Client client}) {
    _client = client;
  }

  late final Client _client;

  /// Returns n random images from the coffee API
  Future<List<String>> getCoffeeImages(int ammount) async {
    assert(ammount > 0, 'ammount of images requested must be greater than 0');

    final images = <String>[];
    for (var i = 0; i < ammount; i++) {
      final response = await _client
          .get(Uri.parse('https://coffee.alexflipnote.dev/random.json'));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final photoUrl = json['file'] as String;

        images.add(photoUrl);
      } else {
        throw Exception('Failed to load image');
      }
    }

    return images;
  }

  /// Returns the data of the image from the given url
  Future<Uint8List> getImageData(String url) async {
    final response = await _client.get(Uri.parse(url));

    if (response.statusCode != 200) throw Exception('Failed to load image');

    return response.bodyBytes;
  }

  /// Saves the image data to the device
  Future<String> saveImageToDevice(String url) async {
    final imageData = await getImageData(url);

    try {
      final imageName = url.split('/').last;
      final directory = await getApplicationDocumentsDirectory();
      final output = File('${directory.path}/$imageName');

      final file = await output.writeAsBytes(imageData);

      return file.path;
    } catch (e) {
      throw Exception('Failed to save image: $e');
    }
  }

  /// Gets the image data from the device
  Future<Uint8List> getImageFromDevice(String path) async {
    try {
      final output = File(path);

      final file = await output.readAsBytes();

      return file;
    } catch (e) {
      throw Exception('Failed to read image: $e');
    }
  }
}
