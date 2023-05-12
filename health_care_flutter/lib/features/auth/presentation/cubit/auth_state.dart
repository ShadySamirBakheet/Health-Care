part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class AuthEmptyFieldState extends AuthState {}

class AuthErrorState extends AuthState {
  AuthErrorState({this.error = 'Unknown Error'});

  final String error;
}

class AuthSuccessState extends AuthState {}
