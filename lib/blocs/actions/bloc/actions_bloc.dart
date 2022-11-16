import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/auth/user_auth_repository.dart';

part 'actions_event.dart';
part 'actions_state.dart';

class ActionsBloc extends Bloc<ActionsEvent, ActionsState> {
  ActionsBloc() : super(ActionsInitial()) {
    on<ActionsEvent>(_sendActions);
  }

  FutureOr<void> _sendActions(event, emit) async {
    emit(ActionsSending());

    String useruid = UserAuthRepository.userInstance?.currentUser?.uid ?? "";
    if (useruid == "") {
      print("\t\tUser not authenticated");
      emit(ActionsError(message: "User not authenticated"));
      return null;
    }

    final QuerySnapshot pets = await FirebaseFirestore.instance
        .collection('actions')
        .where('useruid', isEqualTo: useruid)
        .get();

    await FirebaseFirestore.instance
        .collection('actions')
        .doc(pets.docs[0].id)
        .update({
      'food': event.food,
      'water': event.water,
      'sound': event.sound,
    });

    emit(ActionsSuccess());
  }
}
