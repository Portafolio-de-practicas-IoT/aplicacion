import 'package:app/blocs/auth/bloc/auth_bloc.dart';
import 'package:app/blocs/pet_settings/bloc/pet_settings_bloc.dart';
import 'package:app/blocs/statistics/bloc/statistics_bloc.dart';
import 'package:app/screens/actions.dart';
import 'package:app/screens/automations.dart';
import 'package:app/screens/loading_page.dart';
import 'package:app/screens/pet_settings.dart';
import 'package:app/screens/pets.dart';
import 'package:app/screens/sign_in.dart';
import 'package:app/screens/statistics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PetSettingsBloc>(
          create: (context) => PetSettingsBloc(),
        ),
        BlocProvider<StatisticsBloc>(
          create: (context) => StatisticsBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(VerifyAuthEvent()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/pets': (context) => PetsPage(),
        '/actions': (context) => ActionsPage(),
        '/automations': (context) => AutomationsPage(),
        '/pet-settings': (context) => PetSettingsPage(),
        '/statistics': (context) => StatisticsPage(),
      },
      home: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AuthSuccessState) {
            BlocProvider.of<StatisticsBloc>(context).add(LoadStatistics());
            return StatisticsPage();
          } else if (state is UnAuthState ||
              state is AuthErrorState ||
              state is SignOutSuccessState) {
            return SignIn();
          } else {
            return LoadingPage();
          }
        },
      ),
    );
  }
}
