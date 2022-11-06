import 'package:flutter/material.dart';
import 'package:maternal_health_data/shared/fields/text_input.dart';
import 'package:maternal_health_data/shared/utils/toast.dart';
import 'package:provider/provider.dart';

import '../../shared/state/search.dart';
import '../details/details.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);
  final TextEditingController searchTextController = TextEditingController();

  onPressed(BuildContext context) async {
    String regNo = searchTextController.text.trim();
    bool isSuccess =
        await Provider.of<SearchProvider>(context, listen: false).search(regNo);
    if (isSuccess) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Details()));
    } else {
      Utilities.showToast(
          "Could not find data for the registration number $regNo");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextInputField(
                  controller: searchTextController,
                  label: "Registration Number",
                  type: "text",
                ),
                const Padding(padding: EdgeInsets.only(top: 16)),
                Consumer<SearchProvider>(
                  builder: (context, searchState, child) => ElevatedButton(
                      onPressed: () => onPressed(context),
                      child: Text(
                          searchState.loading ? "Searching..." : "Search")),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
