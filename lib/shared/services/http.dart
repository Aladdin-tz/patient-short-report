import 'dart:io';

import 'package:dio/dio.dart';
import 'package:maternal_health_data/shared/models/credentials.dart';

class HttpService {
  Dio dio = Dio();
  late Credentials credentials;
  late Options options;

  Future<HttpService> init() async {
    Credentials? cred = await Credentials.fromStorage();
    if (cred == null) throw "Credentials not found";
    credentials = cred;
    setOptions();
    return this;
  }

  setOptions() {
    options = Options(headers: {
      HttpHeaders.authorizationHeader: 'Basic ${credentials.authorization}',
      'Content-Type': 'application/json',
    });
  }

  HttpService initWithCredentials(Credentials credentials) {
    this.credentials = credentials;
    setOptions();
    return this;
  }

  Future<Response> get(String path, {Map<String, String>? params}) async {
    Uri? originalUri = Uri.tryParse('https://${credentials.url}');
    if (originalUri != null) {
      String url = 'api/$path';
      Uri uri = Uri.https(originalUri.host, '${originalUri.path}/$url', params);
      return await dio.getUri(uri, options: options);
    } else {
      String url = 'https://${credentials.url}/api/$path';
      return await dio.get(url, options: options);
    }
  }
}
