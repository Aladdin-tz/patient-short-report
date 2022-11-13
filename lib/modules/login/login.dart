import 'package:flutter/material.dart';
import 'package:maternal_health_data/modules/landing/landing.dart';
import 'package:maternal_health_data/shared/fields/text_input.dart';
import 'package:maternal_health_data/shared/models/credentials.dart';
import 'package:maternal_health_data/shared/utils/toast.dart';
import 'package:provider/provider.dart';

import '../../shared/state/user.dart';

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
        await Provider.of<UserProvider>(context, listen: false).init();
        if (!mounted) return;
        navigateToLanding(context);
      } else {
        Utilities.showToast("Invalid url/username/password");
      }
    } catch (e) {
      Utilities.showToast("Error: ${e.toString()}");
    }
    setState(() {
      loading = false;
    });
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
              child: const Center(
                  child: Text(
                "Patient Short Report",
                style: TextStyle(color: Colors.white, fontSize: 32),
              )),
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
    Utilities.showToast("Login successful");

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => const Landing()));
  }
}
