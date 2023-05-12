/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

class User extends _i1.SerializableEntity {
  User({
    this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.password,
    this.authKey,
  });

  factory User.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return User(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      name: serializationManager.deserialize<String>(jsonSerialization['name']),
      email:
          serializationManager.deserialize<String>(jsonSerialization['email']),
      gender:
          serializationManager.deserialize<bool>(jsonSerialization['gender']),
      password: serializationManager
          .deserialize<String>(jsonSerialization['password']),
      authKey: serializationManager
          .deserialize<String?>(jsonSerialization['authKey']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String email;

  bool gender;

  String password;

  String? authKey;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'gender': gender,
      'password': password,
      'authKey': authKey,
    };
  }
}
