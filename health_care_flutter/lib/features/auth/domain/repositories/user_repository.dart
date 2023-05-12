import 'package:health_care_client/health_care_client.dart';

abstract class UserRepository {
  Future<User?> signInUser({
    required String email,
    required String password,
  });

  Future signOut();

  Future<User?> registerNewUser({required User user});

  Future<String?> forgotPassword({required String email});

  Future<String?> changePassword({required String newPassword});
  Future<User?> myUser();
}
