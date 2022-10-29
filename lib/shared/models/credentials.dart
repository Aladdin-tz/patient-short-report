import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:maternal_health_data/shared/services/credentials.dart';
import 'package:maternal_health_data/shared/services/http.dart';

class Credentials {
  late String url;
  late String username;
  late String password;

  Credentials(
      {required this.username, required this.url, required this.password});

  Credentials.fromMap(Map<String, String> map) {
    url = map['url'] ?? '';
    username = map['username']!;
    password = map['password']!;
  }

  get authorization {
    return base64Encode(utf8.encode('$username:$password'));
  }

  static Future<Credentials?> fromStorage() async {
    CredentialsService service = CredentialsService();
    Map<String, String>? credentialsMap = await service.getCredentials();
    if (credentialsMap == null || credentialsMap.isEmpty) return null;
    return Credentials.fromMap(credentialsMap);
  }

  Future save() async {
    return CredentialsService()
        .setCredentials(url: url, username: username, password: password);
  }

  Future clear() async {
    return CredentialsService().clearCredentials();
  }

  Future<bool> validate() async {
    HttpService http = HttpService().initWithCredentials(this);
    try {
      Response response = await http.get('me');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
