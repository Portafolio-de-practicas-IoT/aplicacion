import 'package:app/blocs/pet_settings/bloc/pet_settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';

import '../widgets/side_menu.dart';

class PetsPage extends StatelessWidget {
  PetsPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final ImagePicker _picker = ImagePicker();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

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
              _showDialog(context);
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
                      height: MediaQuery.of(context).size.height * 0.175,
                      child: ClipOval(
                        child: Image.network(
                          pets[index]["image"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    pets[index]["name"],
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Future<dynamic> _showDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add a new pet"),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          contentPadding: EdgeInsets.all(22.0),
          content: _form(context),
        );
      },
    );
  }

  _form(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: "Name",
            ),
          ),
          TextFormField(
            controller: _ageController,
            decoration: InputDecoration(
              labelText: "Age",
            ),
          ),
          TextFormField(
            controller: _weightController,
            decoration: InputDecoration(
              labelText: "Weight",
            ),
          ),
          MaterialButton(
            onPressed: () async {
              final XFile? image =
                  await _picker.pickImage(source: ImageSource.gallery);
              // TODO: Upload image to Firebase Storage and get URL
            },
            child: Text("Select image"),
          ),
          SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              BlocProvider.of<PetSettingsBloc>(context).add(
                CreatePetEvent(
                  name: _nameController.text,
                  age: _ageController.text,
                  weight: _weightController.text,
                  image: "https://i.imgur.com/BoN9kdC.png",
                ),
              );
              // TODO: Add pet to database
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }
}
