import 'package:app/blocs/pet_settings/bloc/pet_settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/side_menu.dart';

class PetsPage extends StatelessWidget {
  PetsPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Your Pets',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.blue,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.blue,
            ),
            onPressed: () {
              // TODO: Add pet
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      drawer: SideMenu(
        currentPath: "/pets",
      ),
      body: _getPets(context),
    );
  }

  BlocConsumer<PetSettingsBloc, PetSettingsState> _getPets(
      BuildContext context) {
    return BlocConsumer<PetSettingsBloc, PetSettingsState>(
      listener: (context, state) {
        if (state is PetSettingsError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
        }
      },
      builder: (context, state) {
        if (state is PetSettingsLoaded) {
          final List<dynamic> pets = state.pets;
          return _petGrid(pets);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _petGrid(List<dynamic> pets) {
    return Column(
      children: [
        GridView.builder(
          padding: EdgeInsets.all(16.0),
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: pets.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        "/pet-settings",
                        arguments: {
                          "name": pets[index]["name"],
                          "age": pets[index]["age"],
                          "status": pets[index]["status"],
                          "weight": pets[index]["weight"],
                          "image": pets[index]["image"],
                        },
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: ClipOval(
                        child: Image.network(
                          pets[index]["image"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(pets[index]["name"]),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
