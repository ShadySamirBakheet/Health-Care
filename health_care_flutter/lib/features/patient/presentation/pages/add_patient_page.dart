import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_flutter/core/presentation/widgets/app_buttons.dart';
import 'package:health_care_flutter/core/presentation/widgets/form_builder.dart';
import 'package:health_care_flutter/core/resources/color_manager.dart';
import 'package:health_care_flutter/core/resources/strings_manager.dart';
import 'package:health_care_flutter/core/resources/styles_manager.dart';
import 'package:health_care_flutter/core/resources/values_manager.dart';
import 'package:health_care_flutter/features/patient/presentation/cubit/patient_cubit.dart';

class AddPatientPage extends StatelessWidget {
  const AddPatientPage({
    super.key,
    this.isEdit = false,
    this.paientId,
  });
  final bool isEdit;
  final int? paientId;
  @override
  Widget build(BuildContext context) {
    if (isEdit) {
      Future.microtask(() {
        PatientCubit.cubit(context).getEdit(paientId!);
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? AppStrings.editPaient : AppStrings.addPaient,
          style: FontStyles.bold22Primary,
        ),
        elevation: AppSize.s0p5,
      ),
      body: BlocConsumer<PatientCubit, PatientState>(
        listener: (context, state) {
          if (state is PatientDone) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is PatientLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
            child: Form(
              key: PatientCubit.cubit(context).formKay,
              child: ListView(
                children: [
                  TextFieldApp(
                    label: AppStrings.name,
                    margin: const EdgeInsets.symmetric(
                      vertical: AppPadding.p12,
                      horizontal: AppPadding.p32,
                    ),
                    keyboardType: TextInputType.name,
                    controller: PatientCubit.cubit(context).nameCtn,
                  ),
                  TextFieldApp(
                    label: AppStrings.age,
                    margin: const EdgeInsets.symmetric(
                      vertical: AppPadding.p12,
                      horizontal: AppPadding.p32,
                    ),
                    keyboardType: TextInputType.number,
                    controller: PatientCubit.cubit(context).ageCtn,
                  ),
                  GenderFiled(
                    label: AppStrings.gender,
                    margin: const EdgeInsets.symmetric(
                      vertical: AppPadding.p12,
                      horizontal: AppPadding.p32,
                    ),
                    initialValue: PatientCubit.cubit(context).maleGender,
                    onChanged: PatientCubit.cubit(context).onChangedGender,
                  ),
                  TextFieldApp(
                    label: AppStrings.desc,
                    margin: const EdgeInsets.symmetric(
                      vertical: AppPadding.p12,
                      horizontal: AppPadding.p32,
                    ),
                    keyboardType: TextInputType.text,
                    maxLines: AppSize.s4.toInt(),
                    controller: PatientCubit.cubit(context).healthyShortCtn,
                  ),
                  TextFieldApp(
                    label: AppStrings.note,
                    margin: const EdgeInsets.symmetric(
                      vertical: AppPadding.p12,
                      horizontal: AppPadding.p32,
                    ),
                    keyboardType: TextInputType.text,
                    maxLines: AppSize.s10.toInt(),
                    controller: PatientCubit.cubit(context).healthyCtn,
                  ),
                  SelectImageFiled(
                    label: 'label',
                    margin: const EdgeInsets.symmetric(
                      vertical: AppPadding.p12,
                      horizontal: AppPadding.p32,
                    ),
                    onChanged: PatientCubit.cubit(context).onChangedImages,
                    onDelete: PatientCubit.cubit(context).onDelete,
                    images: PatientCubit.cubit(context).images,
                  ),
                  AppButton(
                    onPressed: () {
                      PatientCubit.cubit(context).saveData(isEdit: isEdit);
                    },
                    title: AppStrings.save,
                    horizontalPadding: AppPadding.p32,
                    verticalPadding: AppPadding.p14,
                    backgroundColor: ColorManager.button,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
