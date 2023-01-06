import "package:collection/collection.dart";
import 'package:dio/dio.dart';
import 'package:maternal_health_data/shared/services/http.dart';

class MetadataValue {
  String type;
  String label;
  String id;
  String? programStage;

  MetadataValue(this.id, this.type, this.label, {this.programStage});
}

class Programs {
  static const String mtuha6 = "TJ1YopHhZ5R";
  static const String mtuha7 = "z5on8agEt5a";
  static const String mtuha12 = "QZgamIH3J3k";
  static const String mtuha13 = "PFD5iwkAIN3";
}

class Metadata {
  static MetadataValue MOTHER_NAME =
      MetadataValue("MD3lXheYTkL", "ATTRIBUTE", "Mother’s name");
  static MetadataValue MOTHER_BLOOD_GROUP = MetadataValue(
      "i6QBqcC95dS", "DATA_ELEMENT", "Blood Group",
      programStage: "wAFTa6lrLFK");
  static MetadataValue TT_VACCINATION = MetadataValue(
      "QsP2Yqmwxty", "DATA_ELEMENT", "TT Vaccination",
      programStage: "wAFTa6lrLFK");
  static MetadataValue PARITY = MetadataValue(
      "EsdNJ6Gi0cZ", "DATA_ELEMENT", "Parity",
      programStage: "wAFTa6lrLFK");
  static MetadataValue GRAVITY = MetadataValue(
      "bAp3P8xYAQl", "DATA_ELEMENT", "Gravity",
      programStage: "wAFTa6lrLFK");
  static MetadataValue BLOOD_GROUP = MetadataValue(
      "i6QBqcC95dS", "DATA_ELEMENT", "Blood Group",
      programStage: "wAFTa6lrLFK");
  static MetadataValue FUNDAL_HEIGHT = MetadataValue(
      "J5bxxcte958", "DATA_ELEMENT", "Fundal Height",
      programStage: "wAFTa6lrLFK");
  static MetadataValue FETAL_PRESENTATION = MetadataValue(
      "L4TCZfZyAE3", "DATA_ELEMENT", "Fetal Presentation",
      programStage: "wAFTa6lrLFK");
  static MetadataValue TESTED_HIV_FEMALE = MetadataValue(
      "M7bZvaeaqr5", "DATA_ELEMENT", "Female Tested HIV",
      programStage: "wAFTa6lrLFK");


  static List<MetadataValue> get mtuha06Values {
    return [MOTHER_NAME, MOTHER_BLOOD_GROUP, TT_VACCINATION, PARITY, GRAVITY, BLOOD_GROUP, FUNDAL_HEIGHT, FETAL_PRESENTATION, TESTED_HIV_FEMALE];
  }
  
  static MetadataValue CHILD_SEX =
      MetadataValue("TCRYKeGSABQ", "ATTRIBUTE", "Child's sex");
  static MetadataValue CHILD_WEIGHT = MetadataValue(
      "eKrYQdvaSIw", "DATA_ELEMENT", "Weight of the baby",
      programStage: "Dbdrx3yOGwm");
  static MetadataValue CHILD_GROWTH = MetadataValue(
      "AmLEtIy0OqS", "DATA_ELEMENT", "Child growth",
      programStage: "Dbdrx3yOGwm");

  static List<MetadataValue> get mtuha07Values {
    return [CHILD_SEX, CHILD_WEIGHT, CHILD_GROWTH];
  }

  static MetadataValue MOTHER_PHONE_NUMBER =
      MetadataValue("jBGjYoyWLko", "ATTRIBUTE", "Mother's phone number");
  static MetadataValue MODE_OF_DELIVERY = MetadataValue(
      "p3L26hIFody", "DATA_ELEMENT", "Mode of delivery",
      programStage: "AWYdxWtkJXS");
  static MetadataValue PLACE_OF_DELIVERY = MetadataValue(
      "QpDAp7aVLI5", "DATA_ELEMENT", "Place of delivery",
      programStage: "AWYdxWtkJXS");

  static List<MetadataValue> get mtuha12Values {
    return [MOTHER_PHONE_NUMBER, MODE_OF_DELIVERY, PLACE_OF_DELIVERY];
  }

  static MetadataValue AGE = MetadataValue("j6XLfspcJc8", "ATTRIBUTE", "Age");
  static MetadataValue CHILD_NAME = MetadataValue(
      "IElVrWpvm2Q",
      "DATA_ELEMENT",
      programStage: "Y8ehZ4x0uGZ",
      "Child's name");
  static MetadataValue ARV_FOR_THE_CHILD = MetadataValue(
      "ytGOi4GjBdB",
      "DATA_ELEMENT",
      programStage: "Y8ehZ4x0uGZ",
      "ARV for the child");

  static List<MetadataValue> get mtuha13Values {
    return [AGE, CHILD_NAME, ARV_FOR_THE_CHILD];
  }
}

class DataDisplay {
  String title;
  String value;

  DataDisplay({required this.title, required this.value});
}

class SearchResults {
  late Map trackedEntityInstance;
  late List attributes;
  late List events;
  late String program;

  SearchResults();

  SearchResults.fromJSON(Map json, {required this.program}) {
    attributes = json['attributes'];
    events = (json['enrollments'] as List).first['events'];
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

  String getDataElement(String dataElement, String? programStage) {
    List filteredEvents = programStage != null
        ? events
            .where((element) => element['programStage'] == programStage)
            .toList()
        : events;
    if (filteredEvents.isEmpty) return "";
    Map event = filteredEvents.last;
    List dataValues = event['dataValues'];
    Map? dataValue = dataValues
        .firstWhereOrNull((element) => element['dataElement'] == dataElement);
    if (dataValue != null) {
      return dataValue['value'];
    } else {
      return "";
    }
  }

  static Future<SearchResults?> fromSearch(String keyword, HttpService http,
      {required String program}) async {
    String endpoint = "trackedEntityInstances";
    Map<String, String> params = {
      "ouMode": "ACCESSIBLE",
      "program": program,
      "fields":
          "trackedEntityInstance,attributes[attribute,value],enrollments[enrollment,events[event,programStage,dataValues[*]]]",
      "filter": "s18VrbxvdAy:eq:$keyword"
    };
    Response? response = await http.get(endpoint, params: params);
    if (response.statusCode == 200) {
      List trackedEntityInstances = response.data['trackedEntityInstances'];
      if (trackedEntityInstances.isEmpty) {
        return null;
      }
      Map trackedEntityInstance = trackedEntityInstances.first;
      return SearchResults.fromJSON(trackedEntityInstance, program: program);
    } else {
      return null;
    }
  }

  List<DataDisplay> getDataFromMetadata(List<MetadataValue> values) {
    return values.map((MetadataValue value) {
      String dataValue = value.type == "ATTRIBUTE"
          ? getAttribute(value.id)
          : getDataElement(value.id, value.programStage);
      return DataDisplay(title: value.label, value: dataValue);
    }).toList();
  }

  List<DataDisplay> get details {
    switch (program) {
      case Programs.mtuha6:
        return getDataFromMetadata(Metadata.mtuha06Values);
      case Programs.mtuha7:
        return getDataFromMetadata(Metadata.mtuha07Values);
      case Programs.mtuha12:
        return getDataFromMetadata(Metadata.mtuha12Values);
      case Programs.mtuha13:
        return getDataFromMetadata(Metadata.mtuha13Values);
      default:
        return [];
    }
  }
}
