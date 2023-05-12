/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

class Patient extends _i1.SerializableEntity {
  Patient({
    this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.healthyReport,
    required this.healthyReportShort,
    this.reports,
  });

  factory Patient.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Patient(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      name: serializationManager.deserialize<String>(jsonSerialization['name']),
      age: serializationManager.deserialize<double>(jsonSerialization['age']),
      gender:
          serializationManager.deserialize<bool>(jsonSerialization['gender']),
      healthyReport: serializationManager
          .deserialize<String>(jsonSerialization['healthyReport']),
      healthyReportShort: serializationManager
          .deserialize<String>(jsonSerialization['healthyReportShort']),
      reports: serializationManager
          .deserialize<List<String>?>(jsonSerialization['reports']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  double age;

  bool gender;

  String healthyReport;

  String healthyReportShort;

  List<String>? reports;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'healthyReport': healthyReport,
      'healthyReportShort': healthyReportShort,
      'reports': reports,
    };
  }
}
