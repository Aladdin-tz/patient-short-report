import 'package:dio/dio.dart';
import 'package:maternal_health_data/shared/services/http.dart';

import '../services/credentials.dart';

class User {
  late String username;
  late String firstName;
  late String surname;
  late List organisationUnits;

  User(
      {required this.username,
      required this.firstName,
      required this.surname,
      required this.organisationUnits});

  static Future<User?> getUserFromOnline() async {
    HttpService http = await HttpService().init();
    String endpoint = "me";

    try {
      Response response = await http.get(endpoint, params: {
        "fields": "id,username,firstName,surname,organisationUnits"
      });
      if (response.statusCode == 200) {
        return User(
            username: response.data['username'],
            firstName: response.data['firstName'],
            surname: response.data['surname'],
            organisationUnits: (response.data['organisationUnits']
                    .cast<Map<String, dynamic>>())
                ?.map((Map<String, dynamic> orgUnit) => orgUnit['id'])
                .toList());
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<User?> getUserFromStorage() async {
    Map<String, String> map = await StorageService()
        .getObject(['username', 'firstName', 'surname', 'organisationUnits']);
    if (map.isNotEmpty && map.keys.length == 4) {
      return User(
        username: map['username'] ?? '',
        firstName: map['firstName'] ?? '',
        surname: map['surname'] ?? '',
        organisationUnits: map['organisationUnits']?.split(",") ?? [],
      );
    }
    return null;
  }

  get name {
    return "$firstName $surname";
  }

  Map<String, String> toMap() {
    return {
      "firstName": firstName,
      "surname": surname,
      "organisationUnits": organisationUnits.join(',')
    };
  }

  Future<User> save() async {
    await StorageService().setObject(toMap());
    return this;
  }
}
