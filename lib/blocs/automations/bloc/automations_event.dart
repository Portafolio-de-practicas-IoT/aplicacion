part of 'automations_bloc.dart';

abstract class AutomationsEvent extends Equatable {
  const AutomationsEvent();

  @override
  List<Object> get props => [];
}

class LoadAutomations extends AutomationsEvent {}

class CreateAutomation extends AutomationsEvent {
  final String name;
  final String type;
  final String days;
  final String time;

  const CreateAutomation({
    required this.name,
    required this.type,
    required this.days,
    required this.time,
  });

  @override
  List<Object> get props => [name, type, days, time];

  @override
  String toString() =>
      'CreateAutomation { name: $name, type: $type, days: $days, time: $time }';
}

class EditAutomation extends AutomationsEvent {
  final String id;
  final String name;
  final DateTime time;
  final bool enabled;

  EditAutomation({
    required this.id,
    required this.name,
    required this.time,
    required this.enabled,
  });

  @override
  List<Object> get props => [id, name, time, enabled];

  @override
  String toString() =>
      'EditAutomation { id: $id, name: $name, time: $time, enabled: $enabled }';
}

class DeleteAutomation extends AutomationsEvent {
  final String id;

  DeleteAutomation({required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'DeleteAutomation { id: $id }';
}

class ToggleAutomation extends AutomationsEvent {
  final String id;
  final bool enabled;

  ToggleAutomation({
    required this.id,
    required this.enabled,
  });

  @override
  List<Object> get props => [id, enabled];

  @override
  String toString() => 'ToggleAutomation { id: $id, enabled: $enabled }';
}
