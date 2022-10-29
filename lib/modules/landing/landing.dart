import 'package:flutter/material.dart';
import 'package:maternal_health_data/modules/home/home.dart';
import 'package:maternal_health_data/modules/login/login.dart';
import 'package:maternal_health_data/shared/models/credentials.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  checkCredentials() async {
    Credentials? credentials = await Credentials.fromStorage();
    if (credentials == null) {
      if (!mounted) return;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => const Login()));
      return;
    }
    if (!mounted) return;
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => const Home()));
  }

  @override
  void initState() {
    super.initState();
    checkCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Center(child: CircularProgressIndicator()),
          Padding(padding: EdgeInsets.only(top: 16)),
          Text("Please wait...")
        ],
      ),
    );
  }
}
