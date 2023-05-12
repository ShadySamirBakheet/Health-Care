import 'dart:developer';

import 'package:health_care_server/src/generated/user_class.dart';
import 'package:serverpod/serverpod.dart';

class UserEndpoint extends Endpoint {
  Future<User?> signInUser(
    Session session, {
    required String email,
    required String password,
  }) async {
    var loginUser = await User.findSingleRow(
      session,
      where: (t) => t.email.equals(email),
    );
    if (loginUser?.password == password) {
      // session.auth.
      session.auth.signInUser(loginUser?.id ?? 0, 'method');
      loginUser?.authKey = session.authenticationKey;
      return loginUser;
    }
    return null;
  }

  Future<User?> myUser(Session session) async {
    try {
      var uid = await session.auth.authenticatedUserId;

      if (uid != null) {
        var loginUser = await User.findById(session, uid);
        loginUser?.authKey = session.authenticationKey;
        return loginUser;
      }
    } catch (e) {
      log(e.toString());
    }

    return null;
  }

  Future<void> signOut(Session session) => session.auth.signOutUser();

  Future<User?> registerNewUser(Session session, {required User user}) async {
    await User.insert(session, user);
    session.auth.signInUser(user.id ?? 0, 'method');
    user.authKey = session.authenticationKey;
    return user;
  }

  Future<String?> forgotPassword(Session session,
      {required String email}) async {
    var user = await User.findSingleRow(
      session,
      where: (t) => t.email.equals(email),
    );
    return user?.password;
  }

  Future<String?> changePassword(
    Session session, {
    required String newPassword,
  }) async {
    var userId = await session.auth.authenticatedUserId;
    if (userId != null) {
      var user = await User.findById(session, userId);
      if (user != null) {
        user.password = newPassword;
        await User.update(session, user);
        return user.password;
      }
    }
    return null;
  }
}
