part of 'pet_settings_bloc.dart';

abstract class PetSettingsEvent extends Equatable {
  const PetSettingsEvent();

  @override
  List<Object> get props => [];
}

class LoadPetSettings extends PetSettingsEvent {}

class EditPetEvent extends PetSettingsEvent {
  final String name;
  final String age;
  final String status;
  final String weight;
  final String image;

  EditPetEvent({
    required this.name,
    required this.age,
    required this.status,
    required this.weight,
    required this.image,
  });

  @override
  List<Object> get props => [name, age, status, weight, image];

  @override
  String toString() =>
      'EditPetEvent { name: $name, age: $age, status: $status, weight: $weight, image: $image }';
}
