// lib/features/auth/cubit/auth_state.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_cubit.dart';

@immutable
enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

abstract class AuthState {
  final AuthStatus status;
  final User? user;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({AuthStatus? status, User? user, String? errorMessage});
}

class AuthInitial extends AuthState {
  const AuthInitial({
    AuthStatus status = AuthStatus.initial,
    User? user,
    String? errorMessage,
  }) : super(status: status, user: user, errorMessage: errorMessage);

  @override
  AuthState copyWith({AuthStatus? status, User? user, String? errorMessage}) {
    return AuthInitial(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AuthLoading extends AuthState {
  const AuthLoading({
    AuthStatus status = AuthStatus.loading,
    User? user,
    String? errorMessage,
  }) : super(status: status, user: user, errorMessage: errorMessage);

  @override
  AuthState copyWith({AuthStatus? status, User? user, String? errorMessage}) {
    return AuthLoading(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AuthAuthenticated extends AuthState {
  final User user;
  const AuthAuthenticated(
    this.user, {
    AuthStatus status = AuthStatus.authenticated,
    String? errorMessage,
  }) : super(status: status, user: user, errorMessage: errorMessage);

  @override
  AuthState copyWith({AuthStatus? status, User? user, String? errorMessage}) {
    return AuthAuthenticated(
      user ?? this.user,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated({
    AuthStatus status = AuthStatus.unauthenticated,
    User? user,
    String? errorMessage,
  }) : super(status: status, user: user, errorMessage: errorMessage);

  @override
  AuthState copyWith({AuthStatus? status, User? user, String? errorMessage}) {
    return AuthUnauthenticated(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AuthError extends AuthState {
  final String message;
  const AuthError(
    this.message, {
    AuthStatus status = AuthStatus.error,
    User? user,
  }) : super(status: status, user: user, errorMessage: message);

  @override
  AuthState copyWith({AuthStatus? status, User? user, String? errorMessage}) {
    return AuthError(
      errorMessage ?? message,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
