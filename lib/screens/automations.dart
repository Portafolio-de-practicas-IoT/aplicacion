import 'package:app/blocs/automations/bloc/automations_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/side_menu.dart';

import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class AutomationsPage extends StatefulWidget {
  const AutomationsPage({super.key});

  @override
  State<AutomationsPage> createState() => _AutomationsPageState();
}

class _AutomationsPageState extends State<AutomationsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String documentuid = "";

  final TextEditingController _automationNameController =
      TextEditingController();

  int _selectedAction = 0;
  int _selectedDays = 0;
  var _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
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
            onPressed: () {
              _showAddAutomationDialog(context);
            },
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
                onChanged: (value) async {
                  // TODO: Fix this
                  setState(() {});
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
    if (alarms.length == 0) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            "You don't have any alarms yet",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    } else {
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
  }

  List<TableRow> _getRows(alarms) {
    List<TableRow> rows = [];

    for (int i = 0; i < alarms.length; i++) {
      final alarm = alarms[i];

      final TableRow row = TableRow(
        children: [
          GestureDetector(
            onLongPress: () {
              _showDeleteAutomationDialog(context, alarm.id);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Text(
                    alarm["time"],
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Text(
                    alarm["type"],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: CupertinoSwitch(
                    value: alarm["enabled"],
                    onChanged: (value) {
                      BlocProvider.of<AutomationsBloc>(context).add(
                        ToggleAutomation(
                          id: alarm.id,
                          enabled: value,
                        ),
                      );
                    },
                  ),
                ),
              ],
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
        } else if (state is AutomationsCreated) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("Automation created"),
              ),
            );
          BlocProvider.of<AutomationsBloc>(context).add(LoadAutomations());
        } else if (state is AutomationsDeleted) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("Automation deleted"),
              ),
            );
          BlocProvider.of<AutomationsBloc>(context).add(LoadAutomations());
        } else if (state is AutomationsToggled) {
          BlocProvider.of<AutomationsBloc>(context).add(LoadAutomations());
        }
      },
      builder: (context, state) {
        print(state.toString());
        if (state is AutomationsError) {
          return Center(
            child: Column(
              children: [
                Text(
                  state.message,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<AutomationsBloc>().add(
                          LoadAutomations(),
                        );
                  },
                  child: Text("Retry"),
                ),
              ],
            ),
          );
        } else if (state is AutomationsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AutomationsLoaded) {
          documentuid = state.automations['id'];
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

  void _showAddAutomationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: ((BuildContext context) {
        return StatefulBuilder(
          builder: ((context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              contentPadding: EdgeInsets.all(22.0),
              title: Text("Add automation"),
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _automationNameController,
                      decoration: InputDecoration(
                        labelText: "Name",
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Action",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        DropdownButton(
                          value: _selectedAction,
                          items: [
                            DropdownMenuItem(
                              child: Text("Food"),
                              value: 0,
                            ),
                            DropdownMenuItem(
                              child: Text("Water"),
                              value: 1,
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedAction = value as int;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Days",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        DropdownButton(
                          value: _selectedDays,
                          items: [
                            DropdownMenuItem(
                              child: Text("Everyday"),
                              value: 0,
                            ),
                            DropdownMenuItem(
                              child: Text("Weekdays"),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text("Weekends"),
                              value: 2,
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedDays = value as int;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Time",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    TimePickerSpinner(
                      is24HourMode: false,
                      normalTextStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      highlightedTextStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                      spacing: 30,
                      itemHeight: 50,
                      isForce2Digits: true,
                      onTimeChange: (time) {
                        setState(() {
                          _selectedTime = time;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    if (_automationNameController.text.isNotEmpty) {
                      String type = _selectedAction == 0 ? "Food" : "Water";
                      String days = _selectedDays == 0
                          ? "Everyday"
                          : _selectedDays == 1
                              ? "Weekdays"
                              : "Weekends";
                      String amOrPm = _selectedTime.hour > 12 ? "PM" : "AM";
                      String hour = _selectedTime.hour > 12
                          ? (_selectedTime.hour - 12).toString()
                          : _selectedTime.hour.toString();

                      String time = hour +
                          ":" +
                          _selectedTime.minute.toString() +
                          " " +
                          amOrPm;

                      print("Creating new automation with name: " +
                          _automationNameController.text +
                          " type: " +
                          type +
                          " days: " +
                          days +
                          " time: " +
                          time);
                      BlocProvider.of<AutomationsBloc>(context).add(
                        CreateAutomation(
                          name: _automationNameController.text,
                          type: type,
                          days: days,
                          time: time,
                        ),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text("Creating automation..."),
                          ),
                        );
                      Navigator.of(context).pop();
                    }
                  },
                  child: _automationNameController.text.isEmpty
                      ? Text(
                          "Create",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        )
                      : Text("Create"),
                ),
              ],
            );
          }),
        );
      }),
    );
  }

  void _showDeleteAutomationDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: ((BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          contentPadding: EdgeInsets.all(22.0),
          title: Text("Delete automation"),
          content: Text("Are you sure you want to delete this automation?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<AutomationsBloc>(context).add(
                  DeleteAutomation(
                    id: id,
                  ),
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text("Deleting automation..."),
                    ),
                  );
                Navigator.of(context).pop();
              },
              child: Text("Delete"),
            ),
          ],
        );
      }),
    );
  }
}
