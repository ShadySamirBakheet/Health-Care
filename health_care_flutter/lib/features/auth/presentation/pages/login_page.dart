import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:health_care_flutter/core/presentation/widgets/app_buttons.dart';
import 'package:health_care_flutter/core/presentation/widgets/bold_text.dart';
import 'package:health_care_flutter/core/presentation/widgets/form_builder.dart';
import 'package:health_care_flutter/core/resources/assets_manager.dart';
import 'package:health_care_flutter/core/resources/color_manager.dart';
import 'package:health_care_flutter/core/resources/routes_manager.dart';
import 'package:health_care_flutter/core/resources/strings_manager.dart';
import 'package:health_care_flutter/core/resources/styles_manager.dart';
import 'package:health_care_flutter/core/resources/values_manager.dart';
import 'package:health_care_flutter/features/auth/presentation/cubit/auth_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccessState) {
              Navigator.of(context)
                  .pushReplacementNamed(Routes.homeAuthedRoute);
            }
          },
          builder: (context, state) {
            return Form(
              key: AuthCubit.get(context).formKay,
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
                  if (state is AuthErrorState)
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p32,
                            vertical: AppPadding.p8,
                          ),
                          child: Text(
                            state.error,
                            style: FontStyles.regular15Red,
                          ),
                        ),
                      ],
                    ),
                  TextFieldApp(
                    controller: AuthCubit.get(context).emailCtn,
                    validator: [
                      FormBuilderValidators.email(),
                      FormBuilderValidators.required(),
                    ],
                    label: AppStrings.email,
                    margin: const EdgeInsets.symmetric(
                      vertical: AppPadding.p12,
                      horizontal: AppPadding.p32,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  PasswordField(
                    controller: AuthCubit.get(context).passwordCtn,
                    label: AppStrings.password,
                    validator: [
                      FormBuilderValidators.required(),
                    ],
                    margin: const EdgeInsets.symmetric(
                      vertical: AppPadding.p12,
                      horizontal: AppPadding.p32,
                    ),
                  ),
                  Hero(
                    tag: AppStrings.login,
                    child: AppButton(
                      onPressed: AuthCubit.get(context).login,
                      title: AppStrings.login,
                      horizontalPadding: AppPadding.p32,
                      verticalPadding: AppPadding.p14,
                      backgroundColor: ColorManager.button,
                    ),
                  ),
                  AppTextButton(
                    onPressed: () => Navigator.of(context)
                        .pushReplacementNamed(Routes.forgotPasswordRoute),
                    title: AppStrings.forgotPassword,
                  ),
                  AppTextButton(
                    title: AppStrings.signUP,
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.signUpRoute);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
