/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:health_care_client/src/protocol/patient_class.dart' as _i3;
import 'dart:typed_data' as _i4;
import 'package:health_care_client/src/protocol/user_class.dart' as _i5;
import 'dart:io' as _i6;
import 'protocol.dart' as _i7;

class _EndpointExample extends _i1.EndpointRef {
  _EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

class _EndpointPatient extends _i1.EndpointRef {
  _EndpointPatient(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'patient';

  _i2.Future<_i3.Patient?> getPatientById(int id) =>
      caller.callServerEndpoint<_i3.Patient?>(
        'patient',
        'getPatientById',
        {'id': id},
      );

  _i2.Future<List<_i3.Patient>?> getAllPatient({String? q}) =>
      caller.callServerEndpoint<List<_i3.Patient>?>(
        'patient',
        'getAllPatient',
        {'q': q},
      );

  _i2.Future<_i3.Patient?> addPatient(_i3.Patient patient) =>
      caller.callServerEndpoint<_i3.Patient?>(
        'patient',
        'addPatient',
        {'patient': patient},
      );

  _i2.Future<_i3.Patient?> updatePatient(_i3.Patient patient) =>
      caller.callServerEndpoint<_i3.Patient?>(
        'patient',
        'updatePatient',
        {'patient': patient},
      );

  _i2.Future<bool?> deletePatient(_i3.Patient patient) =>
      caller.callServerEndpoint<bool?>(
        'patient',
        'deletePatient',
        {'patient': patient},
      );

  _i2.Future<String?> getUploadDescription(String path) =>
      caller.callServerEndpoint<String?>(
        'patient',
        'getUploadDescription',
        {'path': path},
      );

  _i2.Future<bool?> verifyUpload(String path) =>
      caller.callServerEndpoint<bool?>(
        'patient',
        'verifyUpload',
        {'path': path},
      );

  _i2.Future<bool?> fileExists(String path) => caller.callServerEndpoint<bool?>(
        'patient',
        'fileExists',
        {'path': path},
      );

  _i2.Future<String?> getPublicUrl(String path) =>
      caller.callServerEndpoint<String?>(
        'patient',
        'getPublicUrl',
        {'path': path},
      );

  _i2.Future<_i4.ByteData?> retrieveFile(String path) =>
      caller.callServerEndpoint<_i4.ByteData?>(
        'patient',
        'retrieveFile',
        {'path': path},
      );
}

class _EndpointUser extends _i1.EndpointRef {
  _EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i2.Future<_i5.User?> signInUser({
    required String email,
    required String password,
  }) =>
      caller.callServerEndpoint<_i5.User?>(
        'user',
        'signInUser',
        {
          'email': email,
          'password': password,
        },
      );

  _i2.Future<_i5.User?> myUser() => caller.callServerEndpoint<_i5.User?>(
        'user',
        'myUser',
        {},
      );

  _i2.Future<void> signOut() => caller.callServerEndpoint<void>(
        'user',
        'signOut',
        {},
      );

  _i2.Future<_i5.User?> registerNewUser({required _i5.User user}) =>
      caller.callServerEndpoint<_i5.User?>(
        'user',
        'registerNewUser',
        {'user': user},
      );

  _i2.Future<String?> forgotPassword({required String email}) =>
      caller.callServerEndpoint<String?>(
        'user',
        'forgotPassword',
        {'email': email},
      );

  _i2.Future<String?> changePassword({required String newPassword}) =>
      caller.callServerEndpoint<String?>(
        'user',
        'changePassword',
        {'newPassword': newPassword},
      );
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    _i6.SecurityContext? context,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
  }) : super(
          host,
          _i7.Protocol(),
          context: context,
          authenticationKeyManager: authenticationKeyManager,
        ) {
    example = _EndpointExample(this);
    patient = _EndpointPatient(this);
    user = _EndpointUser(this);
  }

  late final _EndpointExample example;

  late final _EndpointPatient patient;

  late final _EndpointUser user;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'example': example,
        'patient': patient,
        'user': user,
      };
  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
