import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_flutter/features/auth/domain/repositories/user_repository.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this.repository) : super(SplashInitial());
  static SplashCubit cubit(BuildContext context) => BlocProvider.of(context);

  /// assets
  UserRepository repository;
  Future iniApp() async {
    try {
      final user = await repository.myUser();
      if (user != null) {
        emit(SplashGoHome(authed: true));
      } else {
        emit(SplashGoHome());
      }
    } catch (e) {
      log(e.toString());
      emit(SplashGoHome());
    }
  }
}
