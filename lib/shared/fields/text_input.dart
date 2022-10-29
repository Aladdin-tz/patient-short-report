import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  TextEditingController controller;
  String label;
  String type;
  String? prefix;
  String? helpText;

  TextInputField({
    Key? key,
    required this.controller,
    required this.label,
    required this.type,
    this.helpText,
    this.prefix
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: type == "password",
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          prefixText: prefix, helperText: helpText),
    );
  }
}
