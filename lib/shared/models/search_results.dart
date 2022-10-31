import "package:collection/collection.dart";

class SearchResults {
  late Map trackedEntityInstance;
  late List attributes;
  late List events;

  SearchResults.fromJSON(Map json) {
    List trackedEntityInstances = json['trackedEntityInstances'];
    if (trackedEntityInstance.isEmpty) {
      throw "No results found";
    }
    trackedEntityInstance = trackedEntityInstances.first;
    attributes = trackedEntityInstance['attributes'];
    events = (trackedEntityInstance['enrollments'] as List).first['events'];
  }

  String getAttribute(String attribute) {
    Map? attributeObject = attributes
        .firstWhereOrNull((element) => element['attribute'] == attribute);
    if (attributeObject != null) {
      return attributeObject['value'];
    } else {
      return '';
    }
  }

  List<Map> get details {
    return [
      {
        "title": "Mother's name",
        "value": "${getAttribute("w75KJ2mc4zz")} ${getAttribute("zDhUuAYrxNC")}"
      },
      {"title": "Phone number", "value": getAttribute("Agywv2JGwuq")},
      {"title": "Number of children", "value": "4"},
      {"title": "HIV status", "value": "Positive"},
      {"title": "Blood pressure", "value": "120/70"},
      {"title": "Haemoglobin level", "value": "20"},
      {"title": "Syphilis test results", "value": "Positive"},
      {"title": "Vaginal bleeding", "value": "No"},
      {"title": "Improper baby alignment", "value": "No"},
      {"title": "Mode of delivery", "value": "CS"},
      {"title": "Weight of the baby", "value": "3"},
    ];
  }
}
