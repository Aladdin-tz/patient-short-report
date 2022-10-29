import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CredentialsService {
  final storage = const FlutterSecureStorage();

  Future setCredentials(
      {required String url,
      required String username,
      required String password}) async {
    await storage.write(key: 'url', value: url);
    await storage.write(key: 'username', value: username);
    await storage.write(key: 'password', value: password);
  }

  Future<Map<String, String>?> getCredentials() async {
    return await storage.readAll();
  }

  Future clearCredentials() async {
    await storage.deleteAll();
  }
}
