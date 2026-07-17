// lib/features/auth/cubit/auth_cubit.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_states.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<User?> signInWithEmailPassword(String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  Future<User?> signUpWithEmailPassword(String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user;
    if (user != null) {
      await user.reload();
      return _firebaseAuth.currentUser;
    }
    return null;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService = AuthService();

  AuthCubit() : super(AuthInitial()) {
    _authService.authStateChanges.listen((User? user) {
      if (user != null) {
        emit(
          state.copyWith(
            status: AuthStatus.authenticated,
            user: user,
            errorMessage: null,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: AuthStatus.unauthenticated,
            user: null,
            errorMessage: null,
          ),
        );
      }
    });
  }

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));
    try {
      final user = await _authService.signInWithEmailPassword(email, password);
      if (user != null) {
        emit(
          state.copyWith(
            status: AuthStatus.authenticated,
            user: user,
            errorMessage: null,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: AuthStatus.error,
            errorMessage: 'Login failed. Please try again.',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> logout() async {
    await _authService.signOut();
    emit(
      state.copyWith(
        status: AuthStatus.unauthenticated,
        user: null,
        errorMessage: null,
      ),
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    emit(AuthLoading());
    try {
      final user = await _authService.signUpWithEmailPassword(email, password);
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError('Sign up failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void clearError() {
    if (state.status == AuthStatus.error) {
      emit(
        state.copyWith(status: AuthStatus.unauthenticated, errorMessage: null),
      );
    }
  }
}
