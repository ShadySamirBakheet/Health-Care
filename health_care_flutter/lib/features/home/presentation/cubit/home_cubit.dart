import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_client/health_care_client.dart';
import 'package:health_care_flutter/core/resources/routes_manager.dart';
import 'package:health_care_flutter/core/resources/styles_manager.dart';
import 'package:health_care_flutter/core/resources/values_manager.dart';
import 'package:health_care_flutter/features/patient/domain/repositories/patient_repository.dart';
import 'package:health_care_flutter/features/patient/presentation/cubit/patient_cubit.dart';
import 'package:health_care_flutter/features/qrscaner/presentation/pages/qr_scan.dart';
import 'package:motion_toast/motion_toast.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repository) : super(HomeInitial());

  static HomeCubit cubit(BuildContext context) => BlocProvider.of(context);

  PatientRepository repository;

  List<Patient>? list;
  List<Patient>? all;

  Future<void> getAllpatient({String? keySearch}) async {
    list = await repository.getAllPatient(kaySearch: keySearch);
    all = await repository.getAllPatient(kaySearch: keySearch);
    emit(HomeGetDataSate());
  }

  Future deletePatient(Patient patient) async {
    await repository.deletePatient(
      patient,
    );
    await getAllpatient();
  }

  Future scanQrCode(BuildContext context, {bool isAuthed = false}) async {
    Navigator.push(
      context,
      MaterialPageRoute<QRScanner>(
        builder: (ctx) {
          return QRScanner(
            postCheckIn: (code) {
              log('message of date scaned is "$code"');
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushNamed(
                    isAuthed
                        ? Routes.editPatientRoute
                        : Routes.viewPatientRoute,
                    arguments: int.tryParse(code),
                  )
                  .then((value) => PatientCubit.cubit(context).patient = null);

              MotionToast.success(
                title: Text(
                  'Success Read QR',
                  style: FontStyles.semiBold15White,
                ),
                description: Text(
                  'message of date scaned is "$code"',
                  style: FontStyles.regular15White,
                ),
                toastDuration: const Duration(seconds: 5),
                iconSize: AppSize.s0,
              ).show(context);
            },
          );
        },
      ),
    );
  }

  Future<void> onSearchChanged(String? p0) async {
    if (p0 != null && p0.isNotEmpty) {
      list = [];
      all?.forEach((element) {
        if (element.name.toLowerCase().contains(p0.toLowerCase())) {
          list?.add(element);
        }
      });
    } else {
      list = all;
    }
    emit(HomeGetDataSate());
  }
}
