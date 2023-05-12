import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_client/health_care_client.dart';
import 'package:health_care_flutter/features/auth/domain/repositories/user_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  /// init class
  AuthCubit(this.repository) : super(AuthInitial());
  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  /// assets
  UserRepository repository;

  /// vars
  TextEditingController emailCtn = TextEditingController();
  TextEditingController nameCtn = TextEditingController();
  TextEditingController passwordCtn = TextEditingController();
  TextEditingController confirmPasswordCtn = TextEditingController();
  GlobalKey<FormState> formKay = GlobalKey<FormState>();
  GlobalKey<FormState> formNewKay = GlobalKey<FormState>();

  bool maleGender = true;

  /// methods
  Future<void> login() async {
    if (formKay.currentState?.validate() ?? false) {
      final email = emailCtn.text.trim();
      final password = passwordCtn.text.trim();
      if (email.isNotEmpty && password.isNotEmpty) {
        final user =
            await repository.signInUser(email: email, password: password);
        if (user != null) {
          emit(AuthSuccessState());
        } else {
          emit(AuthErrorState(error: 'Email or Password invaild'));
        }
      } else {
        emit(AuthEmptyFieldState());
      }
    } else {
      emit(AuthEmptyFieldState());
    }
  }

  void onChangedGender({bool? myChoose}) {
    maleGender = myChoose ?? true;
  }

  Future<void> singup() async {
    if (formNewKay.currentState?.validate() ?? false) {
      final email = emailCtn.text.trim();
      final name = nameCtn.text.trim();
      final password = passwordCtn.text.trim();
      final confirmPassword = confirmPasswordCtn.text.trim();
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          password == confirmPassword &&
          name.isNotEmpty) {
        final user = User(
          name: name,
          email: email,
          gender: maleGender,
          password: password,
        );
        final userRes = await repository.registerNewUser(user: user);
        if (userRes != null) {
          emit(AuthSuccessState());
        } else {
          emit(AuthErrorState(error: 'Email or Password invaild'));
        }
      } else {
        emit(AuthEmptyFieldState());
      }
    } else {
      emit(AuthEmptyFieldState());
    }
  }
}
