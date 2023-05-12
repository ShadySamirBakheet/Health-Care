import 'package:flutter/material.dart';
import 'package:health_care_client/health_care_client.dart';
import 'package:health_care_flutter/core/resources/color_manager.dart';
import 'package:health_care_flutter/core/resources/routes_manager.dart';
import 'package:health_care_flutter/core/resources/styles_manager.dart';
import 'package:health_care_flutter/core/resources/values_manager.dart';

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
        trailing: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamed(Routes.editPatientRoute, arguments: patient.id);
          },
          icon: const Icon(
            Icons.edit,
            size: AppSize.s20,
          ),
        ),
      ),
    );
  }
}
