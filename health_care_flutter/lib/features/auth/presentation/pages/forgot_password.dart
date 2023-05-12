import 'package:flutter/material.dart';
import 'package:health_care_flutter/core/presentation/widgets/app_buttons.dart';
import 'package:health_care_flutter/core/presentation/widgets/bold_text.dart';
import 'package:health_care_flutter/core/presentation/widgets/form_builder.dart';
import 'package:health_care_flutter/core/resources/assets_manager.dart';
import 'package:health_care_flutter/core/resources/color_manager.dart';
import 'package:health_care_flutter/core/resources/routes_manager.dart';
import 'package:health_care_flutter/core/resources/strings_manager.dart';
import 'package:health_care_flutter/core/resources/values_manager.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Image.asset(
                IconAssets.logo,
                width: AppSize.s150,
                height: AppSize.s150,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(AppPadding.p12),
              child: DoubleText(
                title: AppStrings.appName,
                color1: ColorManager.button,
              ),
            ),
            const TextFieldApp(
              label: AppStrings.email,
              margin: EdgeInsets.symmetric(
                vertical: AppPadding.p12,
                horizontal: AppPadding.p32,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            Hero(
              tag: AppStrings.login,
              child: AppButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.changePasswordRoute);
                },
                title: AppStrings.changePassword,
                horizontalPadding: AppPadding.p32,
                verticalPadding: AppPadding.p14,
                backgroundColor: ColorManager.button,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
