import 'package:app/blocs/auth/bloc/auth_bloc.dart';
import 'package:app/repositories/auth/user_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/pet_settings/bloc/pet_settings_bloc.dart';

class SideMenu extends StatelessWidget {
  SideMenu({
    Key? key,
    required String currentPath,
  })  : _currentPath = currentPath,
        super(key: key);

  final String _currentPath;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          _buildDrawerHeader(context),
          SizedBox(height: 50),
          _buildDrawerBody(context),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.close,
                color: Colors.blue,
                size: 30,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 32,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: NetworkImage(
                          UserAuthRepository().getCurrentUser()!.photoURL!,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        UserAuthRepository().getCurrentUser()!.displayName!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Text(
                        UserAuthRepository().getCurrentUser()!.email!,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildDrawerBody(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed("/pets");
            BlocProvider.of<PetSettingsBloc>(context).add(LoadPetSettings());
          },
          leading: Icon(
            Icons.pets,
            color: _currentPath == '/pets' ? Colors.blue : Colors.grey,
            size: 30,
          ),
          trailing: Icon(
            _currentPath == '/pets'
                ? Icons.arrow_back_ios
                : Icons.arrow_forward_ios,
            color: _currentPath == '/pets' ? Colors.blue : Colors.grey,
            size: 20,
          ),
          title: Text(
            "Your pets",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed('/statistics');
          },
          leading: Icon(
            Icons.bar_chart,
            color: _currentPath == '/statistics' ? Colors.blue : Colors.grey,
            size: 30,
          ),
          trailing: Icon(
            _currentPath == '/statistics'
                ? Icons.arrow_back_ios
                : Icons.arrow_forward_ios,
            color: _currentPath == '/statistics' ? Colors.blue : Colors.grey,
            size: 20,
          ),
          title: Text(
            "Statistics",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed('/actions');
          },
          leading: Icon(
            Icons.pending_actions,
            color: _currentPath == '/actions' ? Colors.blue : Colors.grey,
            size: 30,
          ),
          trailing: Icon(
            _currentPath == '/actions'
                ? Icons.arrow_back_ios
                : Icons.arrow_forward_ios,
            color: _currentPath == '/actions' ? Colors.blue : Colors.grey,
            size: 20,
          ),
          title: Text(
            "Actions",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed('/automations');
          },
          leading: Icon(
            Icons.timer,
            color: _currentPath == '/automations' ? Colors.blue : Colors.grey,
            size: 30,
          ),
          trailing: Icon(
            _currentPath == '/automations'
                ? Icons.arrow_back_ios
                : Icons.arrow_forward_ios,
            color: _currentPath == '/automations' ? Colors.blue : Colors.grey,
            size: 20,
          ),
          title: Text(
            "Automations",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            BlocProvider.of<AuthBloc>(context).add(
              SignOutEvent(buildcontext: context),
            );
          },
          leading: Icon(
            Icons.logout,
            color: Colors.grey,
            size: 30,
          ),
          title: Text(
            "Log out",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
