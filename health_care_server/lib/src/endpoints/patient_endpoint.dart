import 'dart:typed_data';

import 'package:health_care_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class PatientEndpoint extends Endpoint {
  Future<Patient?> getPatientById(Session session, int id) =>
      Patient.findById(session, id);

  Future<List<Patient>?> getAllPatient(Session session, {String? q}) {
    if (q != null && q.isNotEmpty) {
      return Patient.find(
        session,
        where: (p0) {
          return p0.name.like(q);
        },
      );
    } else {
      return Patient.find(
        session,
      );
    }
  }

  Future<Patient?> addPatient(Session session, Patient patient) async {
    await Patient.insert(session, patient);
    return patient;
  }

  Future<Patient?> updatePatient(Session session, Patient patient) async {
    await Patient.update(session, patient);
    return patient;
  }

  Future<bool?> deletePatient(Session session, Patient patient) async {
    var res = await Patient.delete(
      session,
      where: (p0) {
        return p0.id.equals(patient.id);
      },
    );
    return res >= 0;
  }

  Future<String?> getUploadDescription(Session session, String path) async {
    return await session.storage.createDirectFileUploadDescription(
      storageId: 'public',
      path: path,
    );
  }

  Future<bool?> verifyUpload(Session session, String path) {
    return session.storage.verifyDirectFileUpload(
      storageId: 'public',
      path: path,
    );
  }

  Future<bool?> fileExists(Session session, String path) {
    return session.storage.fileExists(
      storageId: 'public',
      path: path,
    );
  }

  Future<String?> getPublicUrl(Session session, String path) async {
    var url = await session.storage.getPublicUrl(
      storageId: 'public',
      path: path,
    );

    session.log(url?.path ?? 'null');
    return url?.path;
  }

  Future<ByteData?> retrieveFile(Session session, String path) async {
    return await session.storage.retrieveFile(
      storageId: 'public',
      path: path,
    );
  }
}
