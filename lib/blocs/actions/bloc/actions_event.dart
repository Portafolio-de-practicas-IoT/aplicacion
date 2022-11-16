part of 'actions_bloc.dart';

abstract class ActionsEvent extends Equatable {
  const ActionsEvent();

  @override
  List<Object> get props => [];
}

class SendActions extends ActionsEvent {
  final bool food;
  final bool water;
  final bool sound;

  SendActions({
    required this.food,
    required this.water,
    required this.sound,
  });

  @override
  List<Object> get props => [food, water, sound];

  @override
  String toString() =>
      'SendActions { food: $food, water: $water, sound: $sound }';
}
