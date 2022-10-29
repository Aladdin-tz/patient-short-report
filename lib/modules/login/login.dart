import 'package:flutter/material.dart';
import 'package:maternal_health_data/modules/landing/landing.dart';
import 'package:maternal_health_data/shared/fields/text_input.dart';
import 'package:maternal_health_data/shared/models/credentials.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _urlController = TextEditingController();

  bool loading = false;

  onPressed(BuildContext context) async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String url = _urlController.text;
    Credentials credentials =
        Credentials(username: username, url: url, password: password);

    setState(() {
      loading = true;
    });
    try {
      bool isValid = await credentials.validate();

      if (isValid) {
        await credentials.save();
        if (!mounted) return;
        navigateToLanding(context);
      } else {
        Toast.show("Invalid url/username/password",
            duration: Toast.lengthLong, gravity: Toast.bottom);
      }
    } catch (e) {
      Toast.show("Error: ${e.toString()}",
          duration: Toast.lengthLong, gravity: Toast.bottom);
    }
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
                      type: "text",
                      prefix: "https://",
                      helpText: "Example https://play.dhis2.org"),
                  const Padding(padding: EdgeInsets.only(top: 16)),
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
                      onPressed: () => onPressed(context),
                      child: Text(loading ? "Please wait..." : "Login"))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void navigateToLanding(BuildContext context) {
    Toast.show("Login successful",
        duration: Toast.lengthLong, gravity: Toast.bottom);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => Landing()));
  }
}
