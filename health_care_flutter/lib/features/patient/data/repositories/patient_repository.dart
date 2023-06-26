import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:health_care_client/health_care_client.dart';
import 'package:health_care_flutter/core/data/network.dart';
import 'package:health_care_flutter/features/patient/domain/repositories/patient_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

class PatientRepositoryImpl extends PatientRepository {
  @override
  Future<Patient?> addPatient(Patient patient) {
    return Network.client.patient.addPatient(patient);
  }

  @override
  Future<bool?> deletePatient(Patient patient) {
    return Network.client.patient.deletePatient(patient);
  }

  @override
  Future<List<Patient>?> getAllPatient({String? kaySearch}) {
    return Network.client.patient.getAllPatient(q: kaySearch);
  }

  @override
  Future<Patient?> getPatientById(int id) {
    return Network.client.patient.getPatientById(id);
  }

  @override
  Future<Patient?> updatePatient(Patient patient) {
    return Network.client.patient.updatePatient(patient);
  }

  @override
  Future<String?> uploadFile({
    required XFile file,
    required String name,
  }) async {
    final uploadDescription =
        await Network.client.patient.getUploadDescription(name);
    if (uploadDescription != null) {
      final res = Platform.isAndroid
          ? uploadDescription.replaceAll(Network.localHost, Network.realHost)
          : uploadDescription;
      log(res);
      log('${file.name} size ${await file.length()}');
      final uploader = FileUploader(res);
      final fileData = await file.readAsBytes();
      final byteData = fileData.buffer.asByteData();

      await uploader.uploadByteData(byteData).then(
        (value) async {
          log('Uploading $value');
        },
      );
      final url = await Network.client.patient.verifyUpload(name);
      final data = await Network.client.patient.retrieveFile(name);
      log(url.toString());
      log(data.toString());

      if (!(url ?? false)) {
        return null;
      }
      return name;
    }
    return name;
  }

  @override
  Future<void> test(String path) async {
    final data = await Network.client.patient.getPublicUrl(path);
    log(data.toString());
  }

  @override
  Future<ByteData?> getImage(String path) {
    return Network.client.patient.retrieveFile(path);
  }
}
