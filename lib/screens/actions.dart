import 'package:app/blocs/actions/bloc/actions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/side_menu.dart';

class ActionsPage extends StatefulWidget {
  const ActionsPage({super.key});

  @override
  State<ActionsPage> createState() => _ActionsPageState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _ActionsPageState extends State<ActionsPage> {
  bool _food = false;
  bool _water = false;
  bool _sound = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Actions',
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
        currentPath: "/actions",
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Text(
                    "Manual Actions",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Checkbox(
                          value: _food,
                          onChanged: (value) {
                            setState(() {
                              _food = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Feed Now",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Checkbox(
                          value: _water,
                          onChanged: (value) {
                            setState(() {
                              _water = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Refill Water Now",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Checkbox(
                          value: _sound,
                          onChanged: (value) {
                            setState(() {
                              _sound = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Make Sound Now",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                _actions(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  BlocConsumer<ActionsBloc, ActionsState> _actions(BuildContext context) {
    return BlocConsumer<ActionsBloc, ActionsState>(
      listener: (context, state) {
        if (state is ActionsError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
        } else if (state is ActionsSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Actions sent successfully'),
              ),
            );
        }
      },
      builder: (context, state) {
        if (state is ActionsInitial ||
            state is ActionsSuccess ||
            state is ActionsError) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 48.0),
                child: MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  minWidth: 300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  onPressed: () {
                    BlocProvider.of<ActionsBloc>(context).add(SendActions(
                      food: _food,
                      water: _water,
                      sound: _sound,
                    ));
                  },
                  child: Text(
                    "Send Actions",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 48.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
