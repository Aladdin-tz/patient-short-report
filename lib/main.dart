import 'package:flutter/material.dart';
import 'package:maternal_health_data/modules/details/details.dart';
import 'package:maternal_health_data/modules/landing/landing.dart';
import 'package:maternal_health_data/modules/login/login.dart';
import 'package:maternal_health_data/modules/search/landing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maternal Health Data',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Details(),
    );
  }
}
