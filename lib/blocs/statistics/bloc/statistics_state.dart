part of 'statistics_bloc.dart';

abstract class StatisticsState extends Equatable {
  const StatisticsState();

  @override
  List<Object> get props => [];
}

class StatisticsInitial extends StatisticsState {}

class StatisticsLoading extends StatisticsState {}

class StatisticsLoaded extends StatisticsState {
  final Map<String, dynamic> statistics;

  StatisticsLoaded({required this.statistics});

  @override
  List<Object> get props => [statistics];

  @override
  String toString() => 'StatisticsLoaded { statistics: $statistics }';
}

class StatisticsError extends StatisticsState {
  final String message;

  StatisticsError({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'StatisticsError { message: $message }';
}
