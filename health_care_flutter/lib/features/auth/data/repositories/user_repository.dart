// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:health_care_client/health_care_client.dart';
import 'package:health_care_flutter/core/data/cache/cache_helper.dart';
import 'package:health_care_flutter/core/data/network.dart';
import 'package:health_care_flutter/core/resources/strings_manager.dart';
import 'package:health_care_flutter/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryIpml implements UserRepository {
  CacheHelper cacheHelper;
  UserRepositoryIpml({
    required this.cacheHelper,
  });
  @override
  Future<String?> changePassword({required String newPassword}) {
    return Network.client.user.changePassword(newPassword: newPassword);
  }

  @override
  Future<String?> forgotPassword({required String email}) {
    return Network.client.user.forgotPassword(email: email);
  }

  @override
  Future<User?> registerNewUser({required User user}) async {
    final userRes = await Network.client.user.registerNewUser(user: user);
    if (userRes != null) {
      cacheHelper.setMap(key: AppStrings.keyMyUser, value: userRes.toJson());
    }
    return userRes;
  }

  @override
  Future<User?> signInUser({
    required String email,
    required String password,
  }) async {
    final userRes =
        await Network.client.user.signInUser(email: email, password: password);
    if (userRes != null) {
      cacheHelper.setMap(key: AppStrings.keyMyUser, value: userRes.toJson());
    }
    return userRes;
  }

  @override
  Future signOut() async {
    await cacheHelper.removeValue(AppStrings.keyMyUser);
    return Network.client.user.signOut();
  }

  @override
  Future<User?> myUser() async {
    final userData = cacheHelper.getMap(AppStrings.keyMyUser);
    if (userData != null) {
      return User(
        name: userData['name'] as String,
        email: userData['email'] as String,
        gender: userData['gender'] as bool,
        password: userData['password'] as String,
        authKey: userData['authKey'] as String?,
        id: userData['id'] as int,
      );
    } else {
      return null;
    }
  }
}
