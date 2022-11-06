import 'package:flutter/material.dart';
import 'package:maternal_health_data/shared/models/search_results.dart';
import 'package:provider/provider.dart';

import '../../shared/state/search.dart';

class DetailsRow extends StatelessWidget {
  final DataDisplay data;

  const DetailsRow({Key? key, required this.data}) : super(key: key);

  final TextStyle headerStyle = const TextStyle(fontSize: 24);
  final TextStyle valueStyle = const TextStyle(fontSize: 24);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            data.title,
            style: headerStyle,
          ),
          Text(
            ": ",
            style: headerStyle,
          ),
          Text(
            data.value,
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
            print(searchState.data);

            List<Widget> details = searchState.data
                .map((e) => DetailsRow(
                      data: e,
                    ))
                .toList();
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: details,
              ),
            );
          },
        ),
      ),
    );
  }
}
