import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/auth/user_auth_repository.dart';

part 'automations_event.dart';
part 'automations_state.dart';

class AutomationsBloc extends Bloc<AutomationsEvent, AutomationsState> {
  AutomationsBloc() : super(AutomationsInitial()) {
    on<LoadAutomations>(_loadAutomations);
    on<CreateAutomation>(_createAutomation);
    on<EditAutomation>(_editAutomation);
    on<DeleteAutomation>(_deleteAutomation);
    on<ToggleAutomation>(_toggleAutomation);
  }

  FutureOr<void> _loadAutomations(event, emit) async {
    emit(AutomationsLoading());
    print("[AutomationsBloc] Loading automations");

    String useruid = UserAuthRepository.userInstance?.currentUser?.uid ?? "";
    if (useruid == "") {
      print("\t\tUser not authenticated");
      emit(AutomationsError(message: "User not authenticated"));
      return null;
    }

    try {
      final QuerySnapshot automations = await FirebaseFirestore.instance
          .collection('automations')
          .where('useruid', isEqualTo: useruid)
          .get();

      print("\t\tLoaded ${automations.docs.length} automations");

      final List<DocumentSnapshot> automationsDocuments = automations.docs;

      Map<String, dynamic> automationsMap = {
        "id": automationsDocuments[0].id,
      };

      final List<dynamic> settingsMap = automationsDocuments[0]["settings"];
      print("\t\tSettings: $settingsMap");

      final List<dynamic> alarmsList = automationsDocuments[0]["alarms"];
      print("\t\tAlarms: $alarmsList");

      automationsMap["settings"] = settingsMap;

      if (alarmsList.isEmpty) {
        automationsMap["alarms"] = [];
      } else {
        final QuerySnapshot alarms = await FirebaseFirestore.instance
            .collection('alarms')
            .where(FieldPath.documentId, whereIn: alarmsList)
            .get();

        print("\t\tLoaded ${alarms.docs.length} alarms");

        final List<DocumentSnapshot> alarmsDocuments = alarms.docs;
        automationsMap["alarms"] = alarmsDocuments;
      }

      print("\t\tAutomations map: $automationsMap");
      emit(AutomationsLoaded(automations: automationsMap));
    } catch (e) {
      print("Error loading automations: $e");
      emit(AutomationsError(message: "Error loading automations: $e"));
    }
  }

  FutureOr<void> _createAutomation(event, emit) async {
    print("[AutomationsBloc] Creating automation");

    String useruid = UserAuthRepository.userInstance?.currentUser?.uid ?? "";
    if (useruid == "") {
      print("\t\tUser not authenticated");
      emit(AutomationsError(message: "User not authenticated"));
      return null;
    }

    final QuerySnapshot automations = await FirebaseFirestore.instance
        .collection('automations')
        .where('useruid', isEqualTo: useruid)
        .get();

    final List<DocumentSnapshot> automationsDocuments = automations.docs;

    String automationId = automationsDocuments[0].id;

    final DocumentReference newAlarm =
        await FirebaseFirestore.instance.collection('alarms').add({
      "name": event.name,
      "time": event.time,
      "days": event.days,
      "type": event.type,
      "enabled": true,
    });
    print("\t\tCreated alarm ${newAlarm.id}");

    final DocumentReference automationsRef =
        FirebaseFirestore.instance.collection('automations').doc(automationId);

    automationsRef.update({
      "alarms": FieldValue.arrayUnion([newAlarm.id])
    });
    print("\t\tAdded alarm to automations");

    emit(AutomationsCreated());
  }

  FutureOr<void> _editAutomation(event, emit) async {
    // TODO: implement event handler
  }

  FutureOr<void> _deleteAutomation(event, emit) async {
    print("[AutomationsBloc] Deleting automation");

    String useruid = UserAuthRepository.userInstance?.currentUser?.uid ?? "";

    if (useruid == "") {
      print("\t\tUser not authenticated");
      emit(AutomationsError(message: "User not authenticated"));
      return null;
    }
    print("\t\tUser authenticated");

    final QuerySnapshot automations = await FirebaseFirestore.instance
        .collection('automations')
        .where('useruid', isEqualTo: useruid)
        .get();
    print("\t\tLoaded ${automations.docs.length} automations");

    final List<DocumentSnapshot> automationsDocuments = automations.docs;
    print("\t\tLoaded ${automationsDocuments.length} automations");

    String automationId = automationsDocuments[0].id;
    print("\t\tAutomation id: $automationId");

    final DocumentReference automationsRef =
        FirebaseFirestore.instance.collection('automations').doc(automationId);
    print("\t\tAutomation ref: $automationsRef");

    automationsRef.update({
      "alarms": FieldValue.arrayRemove([event.id])
    });

    print("\t\tRemoved alarm from automations");

    final DocumentReference alarmRef =
        FirebaseFirestore.instance.collection('alarms').doc(event.id);
    print("\t\tAlarm ref: $alarmRef");

    await alarmRef.delete();

    print("\t\tDeleted alarm");

    emit(AutomationsDeleted());
  }

  FutureOr<void> _toggleAutomation(event, emit) async {
    print(
        "[AutomationsBloc] Toggling automation ${event.id} to ${event.enabled}");

    final DocumentReference alarmRef =
        FirebaseFirestore.instance.collection('alarms').doc(event.id);

    alarmRef.update({
      "enabled": event.enabled,
    });

    emit(AutomationsToggled());
  }
}
