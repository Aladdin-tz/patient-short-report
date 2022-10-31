import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:maternal_health_data/shared/models/search_results.dart';
import 'package:maternal_health_data/shared/services/http.dart';

class SearchProvider extends ChangeNotifier {
  late SearchResults results;
  late String error;
  bool loading = false;
  HttpService? http;

  init() async {
    http = await HttpService().init();
  }

  Future<bool> search(String regNo) async {
    try {
      if (http != null) {
        if (regNo.isNotEmpty) {
          String endpoint = "trackedEntityInstances";
          Map<String, String> params = {
            "ou": "ImspTQPwCqd",
            "ouMode": "DESCENDANTS",
            "program": "WSGAb5XwJ3Y",
            "fields":
                "trackedEntityInstance,attributes[attribute,value],enrollments[enrollment,events[event,dataValues[dataElement,value]]]",
            "filter": "lZGmxYbs97q:eq:$regNo"
          };
          loading = true;
          notifyListeners();
          Response? response = await http?.get(endpoint, params: params);
          if (response != null && response.statusCode == 200) {
            results = SearchResults.fromJSON(response.data);
            loading = false;
            notifyListeners();
            return true;
          } else {
            error = response?.data;
            loading = false;
            notifyListeners();
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
