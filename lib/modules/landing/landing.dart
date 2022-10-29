import 'package:flutter/material.dart';
import 'package:maternal_health_data/shared/fields/text_input.dart';

class Landing extends StatelessWidget {
  Landing({Key? key}) : super(key: key);
  final TextEditingController _urlController = TextEditingController();

  onPressed() {
    String url = _urlController.text;
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
                      controller: _urlController,
                      label: "URL",
                      type: "text", prefix: "https://", helpText: "Example https://play.dhis2.org"),
                  const Padding(padding: EdgeInsets.only(top: 16)),
                  ElevatedButton(
                      onPressed: onPressed, child: const Text("Continue"))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
