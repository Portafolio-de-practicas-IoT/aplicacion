import 'package:app/screens/automations.dart';
import 'package:app/screens/home.dart';
import 'package:app/screens/statistics.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const HomePage(),
        '/automations': (context) => const AutomationsPage(),
        '/statistics': (context) => const StatisticsPage(),
      },
    );
  }
}
