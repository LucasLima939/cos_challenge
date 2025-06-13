import 'package:cos_challenge/data/adapters/http_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  BaseClient httpClient;
  HttpAdapter httpAdapter;

  const url = 'https://anyUrl';
  const statusCode = 200;
  const body = '{}';

  test(
    'should return a response with the correct status code when the http client is called',
    () async {
      httpClient = MockClient((request) async => Response(body, statusCode));
      httpAdapter = HttpAdapterImpl(httpClient: httpClient);

      final response = await httpAdapter.get(url);
      expect(response.statusCode, statusCode);
      expect(response.body, body);
    },
  );
}
