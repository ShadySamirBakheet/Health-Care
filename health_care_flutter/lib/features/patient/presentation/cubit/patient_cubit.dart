import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_client/health_care_client.dart';
import 'package:health_care_flutter/core/domain/entities/image_type.dart';
import 'package:health_care_flutter/core/resources/styles_manager.dart';
import 'package:health_care_flutter/features/patient/domain/repositories/patient_repository.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

part 'patient_state.dart';

class PatientCubit extends Cubit<PatientState> {
  PatientCubit(this.repository) : super(PatientInitial());

  static PatientCubit cubit(BuildContext context) => BlocProvider.of(context);
  PatientRepository repository;
  ScreenshotController controller = ScreenshotController();
  TextEditingController nameCtn = TextEditingController();
  TextEditingController ageCtn = TextEditingController();
  TextEditingController healthyShortCtn = TextEditingController();
  TextEditingController healthyCtn = TextEditingController();
  GlobalKey<FormState> formKay = GlobalKey<FormState>();
  List<ImageData> images = [];
  bool? maleGender;
  Patient? patient;

  void onChangedGender({bool? myChoose}) {
    maleGender = myChoose ?? true;
  }

  Future shareQrCode() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    await controller.capture().then((image) async {
      if (image != null) {
        try {
          final fileName = DateTime.now().microsecondsSinceEpoch.toString();
          final imagePath = await File('$directory/$fileName.png').create();
          await imagePath.writeAsBytes(image);
          Share.shareXFiles([XFile(imagePath.path)], text: 'You Qr code');
        } catch (error) {
          print('Error ---> $error');
        }
      }
    }).catchError((Object onError) {
      print('Catch Error --->> $onError');
    });
  }

  Future<void> saveData({
    required bool isEdit,
    required BuildContext context,
  }) async {
    final userName = nameCtn.text;
    final age = double.tryParse(ageCtn.text);
    final healthyShort = healthyShortCtn.text;
    final healthy = healthyCtn.text;
    if (userName.isNotEmpty &&
        age != null &&
        healthy.isNotEmpty &&
        maleGender != null &&
        healthyShort.isNotEmpty) {
      final reports = <String>[];
      for (final element in images) {
        if (element.isLocal) {
          final url = await repository.uploadFile(
            file: element.file,
            name:
                'patient/images/${DateTime.now().microsecondsSinceEpoch}${element.file.name}',
          );
          if (url != null) {
            reports.add(url);
          } else {
            MotionToast.error(
              description: Text(
                'Can not upload ${element.file.name}',
                style: FontStyles.regular17Black,
              ),
            ).show(context);
            await Future.delayed(const Duration(seconds: 3), () {});
          }
        }
      }
      if (isEdit) {
        patient?.name = userName;
        patient?.age = age;
        patient?.gender = maleGender ?? false;
        patient?.healthyReport = healthy;
        patient?.healthyReportShort = healthyShort;
        patient?.reports?.addAll(reports);
        print(patient);
        repository.updatePatient(patient!);
      } else {
        final patient = Patient(
          name: userName,
          age: age,
          gender: maleGender!,
          healthyReport: healthy,
          healthyReportShort: healthyShort,
          reports: reports,
        );
        print(patient);
        repository.addPatient(patient);
      }

      emit(PatientDone());
    } else {
      emit(PatientEmptyData());
    }
  }

  void onChangedImages(List<ImageData>? p1) {
    images = p1 ?? [];

    print('data images ---> $p1');
  }

  Future<void> getEdit(int paientId) async {
    emit(PatientLoading());

    patient = await repository.getPatientById(paientId);
    if (patient != null) {
      maleGender = patient?.gender;
      nameCtn.text = patient?.name ?? '';
      healthyShortCtn.text = patient?.healthyReportShort ?? '';
      healthyCtn.text = patient?.healthyReport ?? '';
      ageCtn.text = (patient?.age ?? '').toString();
      await getImages();

      emit(PatientDoneRead());
    } else {
      emit(PatientEmptyData());
    }
  }

  Future<void> getPatient(int paientId) async {
    emit(PatientLoading());
    patient = await repository.getPatientById(paientId);
    print(patient);
    if (patient != null) {
      await getImages(); // add this line
      emit(PatientDoneRead());
    } else {
      emit(PatientEmptyData());
    }
  }

  Future getImages() async {
    images = [];
    for (final element in patient?.reports ?? []) {
      final data = await repository.getImage(element as String);
      final directory = (await getApplicationDocumentsDirectory()).path;
      final ext = element.split('.').last;
      final fileName = DateTime.now().microsecondsSinceEpoch.toString();
      final imagePath = await File('$directory/$fileName.$ext').create();
      await imagePath.writeAsBytes(data?.buffer.asInt8List() ?? []);
      final file = XFile(imagePath.path);

      images.add(ImageData(file: file, isLocal: false, link: element));
    }

    print(images);
  }

  void onDelete(ImageData p1) {
    images.remove(p1);
    patient?.reports?.removeWhere((element) => element == p1.link);
  }
}
