import 'package:flutter/material.dart';
import 'package:maternal_health_data/shared/fields/text_input.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);
  final TextEditingController searchTextController = TextEditingController();

  onPressed() {
    String url = searchTextController.text;
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: Container(
              color: Theme.of(context).primaryColor,
              child: null,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextInputField(
                      controller: searchTextController,
                      label: "Registration Number",
                      type: "text",),
                  const Padding(padding: EdgeInsets.only(top: 16)),
                  ElevatedButton(
                      onPressed: onPressed, child: const Text("Search"))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
