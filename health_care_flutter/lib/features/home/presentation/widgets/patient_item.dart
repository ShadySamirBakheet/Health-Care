import 'package:flutter/material.dart';
import 'package:health_care_client/health_care_client.dart';
import 'package:health_care_flutter/core/resources/color_manager.dart';
import 'package:health_care_flutter/core/resources/routes_manager.dart';
import 'package:health_care_flutter/core/resources/styles_manager.dart';
import 'package:health_care_flutter/core/resources/values_manager.dart';
import 'package:health_care_flutter/features/home/presentation/cubit/home_cubit.dart';

class PatientItem extends StatelessWidget {
  const PatientItem({
    required this.patient,
    super.key,
  });
  final Patient patient;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppPadding.p10,
        vertical: AppPadding.p4,
      ),
      padding: const EdgeInsets.all(
        AppPadding.p10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s10),
        color: ColorManager.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: AppSize.s4,
            blurStyle: BlurStyle.outer,
            color: ColorManager.greyBorder,
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          Navigator.of(context)
              .pushNamed(Routes.viewPatientRoute, arguments: patient.id);
        },
        leading: CircleAvatar(
          child: Text((patient.id ?? 0).toString()),
        ),
        title: Text(
          patient.name,
          style: FontStyles.semiBold15Black,
        ),
        subtitle: Text(
          patient.healthyReportShort,
          style: FontStyles.regular15Black,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(Routes.editPatientRoute, arguments: patient.id);
              },
              icon: const Icon(
                Icons.edit,
                size: AppSize.s20,
              ),
            ),
            IconButton(
              onPressed: () {
                showDeleteDialog(context);
              },
              icon: const Icon(
                Icons.delete_forever,
                size: AppSize.s20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog<dynamic>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Are you sure you want to delete this Patient',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
              ),
            ),
            TextButton(
              onPressed: () async {
                HomeCubit.cubit(context).deletePatient(patient);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Delete',
              ),
            ),
          ],
        );
      },
    );
  }
}
