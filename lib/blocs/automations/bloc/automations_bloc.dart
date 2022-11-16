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

    Map<String, dynamic> automationsData = {
      "id": automationsDocuments[0].id,
      ...automationsDocuments[0].data()! as Map<String, dynamic>,
    };

    emit(AutomationsLoaded(automations: automationsData));
  }

  FutureOr<void> _createAutomation(event, emit) async {
    // TODO: implement event handler
  }

  FutureOr<void> _editAutomation(event, emit) async {
    // TODO: implement event handler
  }

  FutureOr<void> _deleteAutomation(event, emit) async {
    // TODO: implement event handler
  }

  FutureOr<void> _toggleAutomation(event, emit) async {
    // TODO: implement event handler
  }
}
