import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_flutter/core/resources/color_manager.dart';
import 'package:health_care_flutter/core/resources/styles_manager.dart';
import 'package:health_care_flutter/core/resources/values_manager.dart';
import 'package:health_care_flutter/features/patient/presentation/cubit/patient_cubit.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';

class PatientDetailsPage extends StatelessWidget {
  const PatientDetailsPage({
    required this.paientId,
    super.key,
  });
  final int paientId;

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      PatientCubit.cubit(context).getPatient(paientId);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          paientId.toString(),
          style: FontStyles.bold22Primary,
        ),
        elevation: AppSize.s0p5,
        actions: [
          IconButton(
            onPressed: () {
              PatientCubit.cubit(context).shareQrCode();
            },
            icon: const Icon(
              Icons.share,
              color: ColorManager.primary,
            ),
          )
        ],
      ),
      body: BlocConsumer<PatientCubit, PatientState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PatientLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(AppPadding.p10),
            children: [
              Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
                child: Center(
                  child: Text(
                    PatientCubit.cubit(context).patient?.name ?? '',
                    style: FontStyles.semiBold22Black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: Center(
                  child: Screenshot<dynamic>(
                    controller: PatientCubit.cubit(context).controller,
                    child: Container(
                      padding: const EdgeInsets.all(AppPadding.p12),
                      color: ColorManager.white,
                      child: PrettyQr(
                        size: MediaQuery.of(context).size.width * .7,
                        data: paientId.toString(),
                        roundEdges: true,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
                child: Text(
                  PatientCubit.cubit(context).patient?.healthyReportShort ?? '',
                  style: FontStyles.semiBold17Black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
                child: Text(
                  PatientCubit.cubit(context).patient?.healthyReport ?? '',
                  style: FontStyles.regular17Black,
                ),
              ),
              ...PatientCubit.cubit(context).images.map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(AppPadding.p10),
                      child: Image.file(
                        File(e.file.path),
                      ),
                    ),
                  ),
              const SizedBox(
                height: AppSize.s32,
              )
            ],
          );
        },
      ),
    );
  }
}
