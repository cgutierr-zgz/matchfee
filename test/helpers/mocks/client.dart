import 'package:http/http.dart';
import 'package:http/testing.dart';

MockClient mockClient = MockClient(
  (request) async => Response('{"file":  "test"}', 200),
);
