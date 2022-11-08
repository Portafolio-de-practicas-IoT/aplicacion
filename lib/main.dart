import 'package:app/blocs/pet_settings/bloc/pet_settings_bloc.dart';
import 'package:app/screens/actions.dart';
import 'package:app/screens/automations.dart';
import 'package:app/screens/home.dart';
import 'package:app/screens/pet_settings.dart';
import 'package:app/screens/pets.dart';
import 'package:app/screens/sign_in.dart';
import 'package:app/screens/statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MultiBlocProvider(
      providers: [
        BlocProvider<PetSettingsBloc>(
          create: (context) => PetSettingsBloc(),
        ),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  MyApp({super.key});

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
