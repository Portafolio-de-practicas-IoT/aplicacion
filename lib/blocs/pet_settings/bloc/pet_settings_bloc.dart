import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pet_settings_event.dart';
part 'pet_settings_state.dart';

class PetSettingsBloc extends Bloc<PetSettingsEvent, PetSettingsState> {
  Map<String, dynamic> mockedData = {
    "pets": [
      {
        "name": "Sierra",
        "age": "3 years",
        "status": "Well fed",
        "weight": "14.65Kg",
        "image":
            "https://cdn.arstechnica.net/wp-content/uploads/2022/04/GettyImages-997016774.jpg"
      },
      {
        "name": "Astro",
        "age": "3 months",
        "status": "Bad fed",
        "weight": "640g",
        "image":
            "https://www.princeton.edu/sites/default/files/styles/half_2x/public/images/2022/02/KOA_Nassau_2697x1517.jpg?itok=iQEwihUn"
      },
      {
        "name": "Sky",
        "age": "8 years",
        "status": "Well fed",
        "weight": "23.4Kg",
        "image":
            "https://cdn.britannica.com/49/161649-050-3F458ECF/Bernese-mountain-dog-grass.jpg"
      }
    ]
  };

  PetSettingsBloc() : super(PetSettingsInitial()) {
    on<LoadPetSettings>(_loadPets);
    on<EditPetEvent>(_editPet);
  }

  // TODO: Implement the loadPets method using Firebase

  FutureOr<void> _loadPets(
    LoadPetSettings event,
    Emitter<PetSettingsState> emit,
  ) {
    emit(PetSettingsLoading());

    emit(PetSettingsLoaded(pets: mockedData["pets"]));
  }

  FutureOr<void> _editPet(
    EditPetEvent event,
    Emitter<PetSettingsState> emit,
  ) {
    emit(PetSettingsLoading());

    emit(PetSettingsLoaded(pets: mockedData["pets"]));
  }
}
