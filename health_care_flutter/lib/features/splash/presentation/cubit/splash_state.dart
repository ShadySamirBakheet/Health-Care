// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'splash_cubit.dart';

abstract class SplashState {
  const SplashState();
}

class SplashInitial extends SplashState {}

class SplashGoHome extends SplashState {
  final bool authed;
  SplashGoHome({
    this.authed = false,
  });
}
