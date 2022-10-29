import 'package:flutter/material.dart';

class DetailsRow extends StatelessWidget {
  final String title;
  final String value;

  const DetailsRow({Key? key, required this.title, required this.value})
      : super(key: key);

  final TextStyle headerStyle = const TextStyle(fontSize: 24);
  final TextStyle valueStyle = const TextStyle(fontSize: 24);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: headerStyle,
          ),
          Text(
            ": ",
            style: headerStyle,
          ),
          Text(
            value,
            style: valueStyle,
          )
        ],
      ),
    );
  }
}

class Details extends StatelessWidget {
  Details({Key? key}) : super(key: key);

  final List<Map<String, String>> rows = [
    {"title": "Mother's name", "value": "Jannet Wambura"},
    {"title": "Phone number", "value": "0753375152"},
    {"title": "Number of children", "value": "4"},
    {"title": "HIV status", "value": "Jannet Wambura"},
    {"title": "Blood pressure", "value": "120/70"},
    {"title": "Haemoglobin level", "value": "20"},
    {"title": "Syphilis test results", "value": "Positive"},
    {"title": "Vaginal bleeding", "value": "No"},
    {"title": "Improper baby alignment", "value": "No"},
    {"title": "Mode of delivery", "value": "CS"},
    {"title": "Weight of the baby", "value": "3"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: rows
              .map((e) =>
                  DetailsRow(title: e['title'] ?? '', value: e['value'] ?? ''))
              .toList(),
        ),
      ),
    );
  }
}
