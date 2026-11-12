import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthUnauthenticatedState extends AuthState {}

class AuthSuccessState extends AuthState {
  final User user;

  const AuthSuccessState(this.user);

  @override
  List<Object?> get props => [user.uid];
}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthLogoutState extends AuthState {}
