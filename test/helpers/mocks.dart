// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

export 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class FakePathProviderPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async =>
      'applicationDocumentsPath';
}

class MockClient extends Mock implements Client {}

class MockFile extends Mock implements File {}

class MockDirectory extends Mock implements Directory {}
