import 'package:flutter/material.dart';
import 'package:maternal_health_data/shared/fields/text_input.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  onPressed() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    print(username);
    print(password);
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
                      controller: _usernameController,
                      label: "Username",
                      type: "text"),
                  const Padding(padding: EdgeInsets.only(top: 16)),
                  TextInputField(
                      controller: _passwordController,
                      label: "Password",
                      type: "password"),
                  ElevatedButton(
                      onPressed: onPressed, child: const Text("Login"))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
