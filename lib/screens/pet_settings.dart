import 'package:app/blocs/pet_settings/bloc/pet_settings_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/side_menu.dart';

class PetSettingsPage extends StatelessWidget {
  PetSettingsPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _args = ModalRoute.of(context)!.settings.arguments;
    _args as Map<String, dynamic>;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Settings',
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
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      drawer: SideMenu(
        currentPath: "/pets",
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ClipOval(
                  child: Image.network(
                    _args["image"],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _args["name"],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
                onPressed: () {
                  _nameController.text = _args["name"];
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          title: Text("Edit name"),
                          content: TextField(
                            controller: _nameController,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () async {
                                print(
                                    'Updating pet name to ${_nameController.text}');
                                print('Pet id: ${_args["id"]}');
                                await FirebaseFirestore.instance
                                    .collection("pets")
                                    .doc(_args["id"])
                                    .update({
                                  "name": _nameController.text,
                                });
                                print("Updated pet name");
                                _args["name"] = _nameController.text;

                                Navigator.of(context).pop();
                              },
                              child: Text("Save"),
                            ),
                          ],
                        );
                      }));
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Table(
                  border: TableBorder(
                    horizontalInside: BorderSide(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      width: 1,
                    ),
                  ),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Amount of food",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "430gr",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Age",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Text(
                                _args["age"],
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  _nameController.text = _args["age"];
                                  showDialog(
                                    context: context,
                                    builder: ((context) {
                                      return AlertDialog(
                                        title: Text("Edit age"),
                                        content: TextField(
                                          controller: _nameController,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              print(
                                                  'Updating pet age to ${_nameController.text}');
                                              print('Pet id: ${_args["id"]}');
                                              await FirebaseFirestore.instance
                                                  .collection("pets")
                                                  .doc(_args["id"])
                                                  .update({
                                                "age": _nameController.text,
                                              });
                                              print("Updated pet age");
                                              _args["age"] =
                                                  _nameController.text;

                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Save"),
                                          ),
                                        ],
                                      );
                                    }),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Weight",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Text(
                                _args["weight"],
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  _nameController.text = _args["weight"];
                                  showDialog(
                                    context: context,
                                    builder: ((context) {
                                      return AlertDialog(
                                        title: Text("Edit weight"),
                                        content: TextField(
                                          controller: _nameController,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              print(
                                                  'Updating pet weight to ${_nameController.text}');
                                              print('Pet id: ${_args["id"]}');
                                              await FirebaseFirestore.instance
                                                  .collection("pets")
                                                  .doc(_args["id"])
                                                  .update({
                                                "weight": _nameController.text,
                                              });
                                              print("Updated pet weight");
                                              _args["weight"] =
                                                  _nameController.text;

                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Save"),
                                          ),
                                        ],
                                      );
                                    }),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            color: Colors.red,
            textColor: Colors.white,
            minWidth: 300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: ((context) {
                  return AlertDialog(
                    title: Text("Delete pet"),
                    content: Text("Are you sure you want to delete this pet?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async {
                          print('Deleting pet');
                          print('Pet id: ${_args["id"]}');
                          await FirebaseFirestore.instance
                              .collection("pets")
                              .doc(_args["id"])
                              .delete();
                          print("Deleted pet");
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text("Delete"),
                      ),
                    ],
                  );
                }),
              );
            },
            child: Text(
              "Delete this pet",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            minWidth: 300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              BlocProvider.of<PetSettingsBloc>(context).add(
                LoadPetSettings(),
              );
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Pet updated"),
                  ),
                );
            },
            child: Text(
              "Save",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
