import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  TextEditingController controller;
  String label;
  String type;

  TextInputField({
    Key? key,
    required this.controller,
    required this.label,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: type == "password",
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label
      ),
    );
  }
}
