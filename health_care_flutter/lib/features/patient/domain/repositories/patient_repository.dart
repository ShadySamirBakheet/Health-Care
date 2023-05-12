import 'dart:typed_data';

import 'package:health_care_client/health_care_client.dart';
import 'package:image_picker/image_picker.dart';

abstract class PatientRepository {
  Future<bool?> deletePatient(Patient patient);
  Future<Patient?> updatePatient(Patient patient);
  Future<Patient?> addPatient(Patient patient);
  Future<List<Patient>?> getAllPatient({String? kaySearch});
  Future<Patient?> getPatientById(int id);
  Future<String?> uploadFile({required XFile file, required String name});
  Future<void> test(String path);
  Future<ByteData?> getImage(String path);
}
