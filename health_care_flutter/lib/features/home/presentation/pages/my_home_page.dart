import 'package:flutter/material.dart';
import 'package:health_care_flutter/core/presentation/widgets/app_buttons.dart';
import 'package:health_care_flutter/core/resources/assets_manager.dart';
import 'package:health_care_flutter/core/resources/color_manager.dart';
import 'package:health_care_flutter/core/resources/routes_manager.dart';
import 'package:health_care_flutter/core/resources/strings_manager.dart';
import 'package:health_care_flutter/core/resources/values_manager.dart';
import 'package:health_care_flutter/features/home/presentation/cubit/home_cubit.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImagesAssets.image1,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: AppButton(
                  onPressed: () {
                    HomeCubit.cubit(context).scanQrCode(context);
                  },
                  title: AppStrings.scan,
                  horizontalPadding: AppPadding.p32,
                  verticalPadding: AppPadding.p14,
                  backgroundColor: ColorManager.button,
                ),
              ),
              Center(
                child: Hero(
                  tag: AppStrings.login,
                  child: AppButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.loginRoute);
                    },
                    title: AppStrings.login,
                    horizontalPadding: AppPadding.p32,
                    verticalPadding: AppPadding.p14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
