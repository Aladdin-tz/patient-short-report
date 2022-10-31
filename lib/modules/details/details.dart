import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/state/search.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Consumer<SearchProvider>(
          builder: (context, searchState, child) {
            print(searchState.results.details);
            List<Widget> details = searchState.results.details
                .map((e) => DetailsRow(
                    title: e['title'] ?? '', value: e['value'] ?? ''))
                .toList();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: details,
            );
          },
        ),
      ),
    );
  }
}
