import 'package:app/screens/actions.dart';
import 'package:app/screens/automations.dart';
import 'package:app/screens/home.dart';
import 'package:app/screens/pet_settings.dart';
import 'package:app/screens/pets.dart';
import 'package:app/screens/sign_in.dart';
import 'package:app/screens/statistics.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomePage(),
        '/pets': (context) => PetsPage(),
        '/statistics': (context) => StatisticsPage(),
        '/actions': (context) => ActionsPage(),
        '/automations': (context) => AutomationsPage(),
        '/pet-settings': (context) => PetSettingsPage(),
        '/sign-in': (context) => SignIn(),
      },
      initialRoute: '/statistics',
    );
  }
}
