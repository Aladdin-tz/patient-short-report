import 'package:flutter/cupertino.dart';
import 'package:maternal_health_data/shared/models/search_results.dart';
import 'package:maternal_health_data/shared/services/http.dart';

class SearchProvider extends ChangeNotifier {
  late List<SearchResults?> results;
  late List<DataDisplay> data;
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
          loading = true;
          notifyListeners();
          List<SearchResults?> results = await Future.wait([
            SearchResults.fromSearch(regNo, http!, program: Programs.mtuha6),
            SearchResults.fromSearch(regNo, http!, program: Programs.mtuha7),
            SearchResults.fromSearch(regNo, http!, program: Programs.mtuha12),
            SearchResults.fromSearch(regNo, http!, program: Programs.mtuha13),
          ]);

          this.results = results.where((element) => element != null).toList();
          print(this.results);
          List<DataDisplay> rawData = [];
          for (SearchResults? result in this.results) {
            if (result == null) {
              continue;
            }
            print(result?.details);
            rawData.addAll(result?.details ?? []);
          }
          print(rawData);
          data = rawData;
          loading = false;
          notifyListeners();
          return true;
        }
      }
    } catch (e) {
      print(e);
      loading = false;
      notifyListeners();
    }
    return false;
  }
}
