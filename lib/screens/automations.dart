import 'dart:io';

import 'package:app/blocs/automations/bloc/automations_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/side_menu.dart';

class AutomationsPage extends StatefulWidget {
  const AutomationsPage({super.key});

  @override
  State<AutomationsPage> createState() => _AutomationsPageState();
}

class _AutomationsPageState extends State<AutomationsPage> {
  final Map<String, dynamic> _mockedData = {
    "alarms": [
      {
        "time": "1:10pm",
        "type": "Food",
        "enabled": true,
      },
      {
        "time": "1:10pm",
        "type": "Water",
        "enabled": true,
      },
      {
        "time": "9:10pm",
        "type": "Food",
        "enabled": true,
      },
      {
        "time": "9:10pm",
        "type": "Water",
        "enabled": true,
      },
      {
        "time": "5:10pm",
        "type": "Food",
        "enabled": false,
      },
    ],
    "settings": [
      {"Eating": true},
      {"Drinking": true},
      {"Make sound to eat": true},
    ]
  };

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Automations',
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
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      drawer: SideMenu(
        currentPath: "/automations",
      ),
      body: _automations(),
    );
  }

  Widget _getActions(from, to, actions) {
    final Table table = Table(
      border: TableBorder(
        horizontalInside: BorderSide(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          width: 1,
        ),
      ),
      children: _getCells(actions, from, to),
    );

    return table;
  }

  List<TableRow> _getCells(actions, from, to) {
    final List<TableRow> rows = [];

    for (int i = from; i < to; i++) {
      final action = actions[i];

      rows.add(
        TableRow(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Text(
                action.keys.first,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: CupertinoSwitch(
                value: action.values.first,
                onChanged: (value) {
                  // TODO: Update the value
                },
              ),
            ),
          ],
        ),
      );
    }

    return rows;
  }

  Widget _getAlarms(List<dynamic> alarms) {
    final Table table = Table(
      border: TableBorder(
        horizontalInside: BorderSide(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          width: 1,
        ),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: _getRows(alarms),
    );

    return table;
  }

  List<TableRow> _getRows(alarms) {
    List<TableRow> rows = [];

    for (int i = 0; i < alarms.length; i++) {
      final alarm = alarms[i];

      final TableRow row = TableRow(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Text(
              alarm["time"],
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Text(
              alarm["type"],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: CupertinoSwitch(
              value: alarm["enabled"],
              onChanged: (value) {
                // TODO: Update the alarm
              },
            ),
          ),
        ],
      );

      rows.add(row);
    }

    return rows;
  }

  BlocConsumer<AutomationsBloc, AutomationsState> _automations() {
    return BlocConsumer<AutomationsBloc, AutomationsState>(
      listener: (context, state) {
        if (state is AutomationsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        print(state.toString());
        if (state is AutomationsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AutomationsLoaded) {
          print("AUTOMATIONS: ${state.automations}");
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: _getAlarms(state.automations["alarms"]),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[200],
                  height: 65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Notify me when my pet is",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: _getActions(0, 2, state.automations["settings"]),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[200],
                  height: 65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Other",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: _getActions(2, 3, state.automations["settings"]),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
