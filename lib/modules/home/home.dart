import 'package:flutter/material.dart';
import 'package:maternal_health_data/modules/landing/landing.dart';
import 'package:maternal_health_data/modules/search/search.dart';
import 'package:maternal_health_data/shared/models/credentials.dart';
import 'package:maternal_health_data/shared/state/search.dart';
import 'package:maternal_health_data/shared/state/user.dart';
import "package:provider/provider.dart";

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  onLogout(BuildContext context) async {
    Credentials? credentials = await Credentials.fromStorage();
    if (credentials != null) {
      await credentials.clear();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const Landing()));
    }
  }

  onSearch(BuildContext context) async {
    await Provider.of<SearchProvider>(context, listen: false).init();
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => Search()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              onPressed: () => onLogout(context),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (context, userState, child) => Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
              child: Text(
                textAlign: TextAlign.start,
                "Hi, ${userState.user?.name ?? ""}",
                style: const TextStyle(fontSize: 36),
              ),
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                  onPressed: () => onSearch(context),
                  child: const Text("Search")),
            )
          ],
        ),
      ),
    );
  }
}
