import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthInitializeEvent extends AuthEvent {
  const AuthInitializeEvent();
}

class AuthSessionChangedEvent extends AuthEvent {
  final User? user;

  const AuthSessionChangedEvent(this.user);

  @override
  List<Object?> get props => [user?.uid];
}

class AuthSessionErrorEvent extends AuthEvent {
  final String message;

  const AuthSessionErrorEvent(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthSignupEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthSignupEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthLogoutEvent extends AuthEvent {
  const AuthLogoutEvent();
}
