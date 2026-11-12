import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sankar/auth/block/event.dart';
import 'package:sankar/auth/block/state.dart';
import '../repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  late final StreamSubscription<User?> _authSubscription;

  AuthBloc(this.authRepository) : super(AuthInitialState()) {
    on<AuthInitializeEvent>((event, emit) {
      final user = authRepository.currentUser;
      emit(user == null ? AuthUnauthenticatedState() : AuthSuccessState(user));
    });

    on<AuthSessionChangedEvent>((event, emit) {
      final user = event.user;
      emit(user == null ? AuthUnauthenticatedState() : AuthSuccessState(user));
    });

    on<AuthSessionErrorEvent>((event, emit) {
      emit(AuthErrorState(event.message));
    });

    _authSubscription = authRepository.authStateChanges.listen(
      (user) => add(AuthSessionChangedEvent(user)),
      onError: (Object error) =>
          add(AuthSessionErrorEvent('Unable to check sign-in status: $error')),
    );

    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoadingState());

      try {
        final result = await authRepository.login(
          email: event.email,
          password: event.password,
        );

        emit(AuthSuccessState(result.user!));
      } on FirebaseAuthException catch (e) {
        emit(AuthErrorState(e.message ?? 'Login failed'));
      } catch (e) {
        emit(AuthErrorState('Something went wrong'));
      }
    });

    on<AuthSignupEvent>((event, emit) async {
      emit(AuthLoadingState());

      try {
        final result = await authRepository.signup(
          email: event.email,
          password: event.password,
        );

        emit(AuthSuccessState(result.user!));
      } on FirebaseAuthException catch (e) {
        emit(AuthErrorState(e.message ?? 'Signup failed'));
      } catch (e) {
        emit(AuthErrorState('Something went wrong'));
      }
    });

    on<AuthLogoutEvent>((event, emit) async {
      emit(AuthLoadingState());

      try {
        await authRepository.logout();
        emit(AuthLogoutState());
      } catch (e) {
        emit(AuthErrorState('Logout failed'));
      }
    });
  }

  @override
  Future<void> close() async {
    await _authSubscription.cancel();
    await super.close();
  }
}
