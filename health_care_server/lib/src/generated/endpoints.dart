/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/example_endpoint.dart' as _i2;
import '../endpoints/patient_endpoint.dart' as _i3;
import '../endpoints/user_endpoint.dart' as _i4;
import 'package:health_care_server/src/generated/patient_class.dart' as _i5;
import 'package:health_care_server/src/generated/user_class.dart' as _i6;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'example': _i2.ExampleEndpoint()
        ..initialize(
          server,
          'example',
          null,
        ),
      'patient': _i3.PatientEndpoint()
        ..initialize(
          server,
          'patient',
          null,
        ),
      'user': _i4.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
    };
    connectors['example'] = _i1.EndpointConnector(
      name: 'example',
      endpoint: endpoints['example']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['example'] as _i2.ExampleEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
    connectors['patient'] = _i1.EndpointConnector(
      name: 'patient',
      endpoint: endpoints['patient']!,
      methodConnectors: {
        'getPatientById': _i1.MethodConnector(
          name: 'getPatientById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['patient'] as _i3.PatientEndpoint).getPatientById(
            session,
            params['id'],
          ),
        ),
        'getAllPatient': _i1.MethodConnector(
          name: 'getAllPatient',
          params: {
            'q': _i1.ParameterDescription(
              name: 'q',
              type: _i1.getType<String?>(),
              nullable: true,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['patient'] as _i3.PatientEndpoint).getAllPatient(
            session,
            q: params['q'],
          ),
        ),
        'addPatient': _i1.MethodConnector(
          name: 'addPatient',
          params: {
            'patient': _i1.ParameterDescription(
              name: 'patient',
              type: _i1.getType<_i5.Patient>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['patient'] as _i3.PatientEndpoint).addPatient(
            session,
            params['patient'],
          ),
        ),
        'updatePatient': _i1.MethodConnector(
          name: 'updatePatient',
          params: {
            'patient': _i1.ParameterDescription(
              name: 'patient',
              type: _i1.getType<_i5.Patient>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['patient'] as _i3.PatientEndpoint).updatePatient(
            session,
            params['patient'],
          ),
        ),
        'deletePatient': _i1.MethodConnector(
          name: 'deletePatient',
          params: {
            'patient': _i1.ParameterDescription(
              name: 'patient',
              type: _i1.getType<_i5.Patient>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['patient'] as _i3.PatientEndpoint).deletePatient(
            session,
            params['patient'],
          ),
        ),
        'getUploadDescription': _i1.MethodConnector(
          name: 'getUploadDescription',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['patient'] as _i3.PatientEndpoint)
                  .getUploadDescription(
            session,
            params['path'],
          ),
        ),
        'verifyUpload': _i1.MethodConnector(
          name: 'verifyUpload',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['patient'] as _i3.PatientEndpoint).verifyUpload(
            session,
            params['path'],
          ),
        ),
        'fileExists': _i1.MethodConnector(
          name: 'fileExists',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['patient'] as _i3.PatientEndpoint).fileExists(
            session,
            params['path'],
          ),
        ),
        'getPublicUrl': _i1.MethodConnector(
          name: 'getPublicUrl',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['patient'] as _i3.PatientEndpoint).getPublicUrl(
            session,
            params['path'],
          ),
        ),
        'retrieveFile': _i1.MethodConnector(
          name: 'retrieveFile',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['patient'] as _i3.PatientEndpoint).retrieveFile(
            session,
            params['path'],
          ),
        ),
      },
    );
    connectors['user'] = _i1.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'signInUser': _i1.MethodConnector(
          name: 'signInUser',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i4.UserEndpoint).signInUser(
            session,
            email: params['email'],
            password: params['password'],
          ),
        ),
        'myUser': _i1.MethodConnector(
          name: 'myUser',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i4.UserEndpoint).myUser(session),
        ),
        'signOut': _i1.MethodConnector(
          name: 'signOut',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i4.UserEndpoint).signOut(session),
        ),
        'registerNewUser': _i1.MethodConnector(
          name: 'registerNewUser',
          params: {
            'user': _i1.ParameterDescription(
              name: 'user',
              type: _i1.getType<_i6.User>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i4.UserEndpoint).registerNewUser(
            session,
            user: params['user'],
          ),
        ),
        'forgotPassword': _i1.MethodConnector(
          name: 'forgotPassword',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i4.UserEndpoint).forgotPassword(
            session,
            email: params['email'],
          ),
        ),
        'changePassword': _i1.MethodConnector(
          name: 'changePassword',
          params: {
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i4.UserEndpoint).changePassword(
            session,
            newPassword: params['newPassword'],
          ),
        ),
      },
    );
  }
}
