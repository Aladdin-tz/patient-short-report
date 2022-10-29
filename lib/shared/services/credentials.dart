import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final storage = const FlutterSecureStorage();

  Future setObject(Map<String, String> object) async {
    for (String key in object.keys) {
      await storage.write(key: key, value: object[key]);
    }
  }

  Future<Map<String, String>> getObject(List<String> keys) async {
    Map<String, String> map = {};
    for (String key in keys) {
      String? value = await storage.read(key: key);
      if (value != null) {
        map[key] = value;
      }
    }

    return map;
  }

  Future<Map<String, String>?> getAllFromStorage() async {
    return await storage.readAll();
  }

  Future clearStorage() async {
    await storage.deleteAll();
  }
}
