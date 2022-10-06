import 'package:http/http.dart';
import 'package:http/testing.dart';

MockClient mockClient = MockClient((request) async {
  return Response('{"id": 1, "name": "test"}', 200);
});
