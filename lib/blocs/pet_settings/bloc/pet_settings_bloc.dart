import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/auth/user_auth_repository.dart';

part 'pet_settings_event.dart';
part 'pet_settings_state.dart';

class PetSettingsBloc extends Bloc<PetSettingsEvent, PetSettingsState> {
  PetSettingsBloc() : super(PetSettingsInitial()) {
    on<LoadPetSettings>(_loadPets);
    on<EditPetEvent>(_editPet);
  }

  Future<FutureOr<void>> _loadPets(
    LoadPetSettings event,
    Emitter<PetSettingsState> emit,
  ) async {
    emit(PetSettingsLoading());

    String useruid = UserAuthRepository.userInstance?.currentUser?.uid ?? "";
    if (useruid == "") {
      print("\t\tUser not authenticated");
      emit(PetSettingsError(message: "User not authenticated"));
      return null;
    }

    final QuerySnapshot pets = await FirebaseFirestore.instance
        .collection('pets')
        .where('useruid', isEqualTo: useruid)
        .get();

    final List<DocumentSnapshot> petsDocuments = pets.docs;

    final List<dynamic> petsData = petsDocuments
        .map((DocumentSnapshot documentSnapshot) => <String, dynamic>{
              "id": documentSnapshot.id,
              ...documentSnapshot.data()! as Map<String, dynamic>,
            })
        .toList();

    emit(PetSettingsLoaded(pets: petsData));
  }

  FutureOr<void> _editPet(
    EditPetEvent event,
    Emitter<PetSettingsState> emit,
  ) {
    emit(PetSettingsLoading());

    emit(PetSettingsLoaded(pets: []));
  }
}
