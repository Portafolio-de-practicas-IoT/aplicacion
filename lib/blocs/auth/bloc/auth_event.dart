part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();

  List<Object> get props => [];
}

class VerifyAuthEvent extends AuthEvent {}

class AnonymousAuthEvent extends AuthEvent {}

class EmailAuthEvent extends AuthEvent {
  final String email;
  final String password;

  const EmailAuthEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class GoogleAuthEvent extends AuthEvent {
  final BuildContext buildcontext;

  GoogleAuthEvent({required this.buildcontext});
}

class SignOutEvent extends AuthEvent {
  final BuildContext buildcontext;

  SignOutEvent({required this.buildcontext});
}

class AuthErrorEvent extends AuthEvent {
  final String error;

  AuthErrorEvent({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AuthErrorEvent { error: $error }';
}
