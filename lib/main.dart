import 'package:flutter/material.dart';
import 'package:maternal_health_data/modules/landing/landing.dart';
import 'package:maternal_health_data/shared/state/search.dart';
import 'package:maternal_health_data/shared/state/user.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<SearchProvider>(create: (_) => SearchProvider()),
      ],
      child: MaterialApp(
        title: 'Patient Short Report',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Landing(),
      ),
    );
  }
}
