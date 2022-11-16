part of 'actions_bloc.dart';

abstract class ActionsState extends Equatable {
  const ActionsState();

  @override
  List<Object> get props => [];
}

class ActionsInitial extends ActionsState {}

class ActionsSending extends ActionsState {}

class ActionsSuccess extends ActionsState {}

class ActionsError extends ActionsState {
  final String message;

  ActionsError({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'ActionsError { message: $message }';
}
