import 'package:http/http.dart';

abstract class HttpAdapter {
  Future<Response> get(String url, {Map<String, String>? headers});
}

class HttpAdapterImpl implements HttpAdapter {
  final BaseClient httpClient;

  HttpAdapterImpl({required this.httpClient});

  @override
  Future<Response> get(String url, {Map<String, String>? headers}) async {
    return await httpClient.get(Uri.parse(url), headers: headers);
  }
}
