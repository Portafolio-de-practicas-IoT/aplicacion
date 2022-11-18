part of 'automations_bloc.dart';

abstract class AutomationsState extends Equatable {
  const AutomationsState();

  @override
  List<Object> get props => [];
}

class AutomationsInitial extends AutomationsState {}

class AutomationsLoading extends AutomationsState {}

class AutomationsCreated extends AutomationsState {}

class AutomationsDeleted extends AutomationsState {}

class AutomationsToggled extends AutomationsState {}

class AutomationsLoaded extends AutomationsState {
  final Map<String, dynamic> automations;

  AutomationsLoaded({required this.automations});

  @override
  List<Object> get props => [automations];

  @override
  String toString() => 'AutomationsLoaded { automations: $automations }';
}

class AutomationsError extends AutomationsState {
  final String message;

  AutomationsError({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'AutomationsError { message: $message }';
}
