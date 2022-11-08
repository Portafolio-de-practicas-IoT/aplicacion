part of 'pet_settings_bloc.dart';

abstract class PetSettingsState extends Equatable {
  const PetSettingsState();

  @override
  List<Object> get props => [];
}

class PetSettingsInitial extends PetSettingsState {}

class PetSettingsLoading extends PetSettingsState {}

class PetSettingsLoaded extends PetSettingsState {
  final List<dynamic> pets;

  PetSettingsLoaded({required this.pets});

  @override
  List<Object> get props => [pets];

  @override
  String toString() => 'PetSettingsLoaded { pets: $pets }';
}

class PetSettingsError extends PetSettingsState {
  final String message;

  PetSettingsError({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'PetSettingsError { message: $message }';
}
