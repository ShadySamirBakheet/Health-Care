import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_flutter/core/presentation/widgets/bold_text.dart';
import 'package:health_care_flutter/core/resources/assets_manager.dart';
import 'package:health_care_flutter/core/resources/routes_manager.dart';
import 'package:health_care_flutter/core/resources/strings_manager.dart';
import 'package:health_care_flutter/core/resources/values_manager.dart';
import 'package:health_care_flutter/features/splash/presentation/cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 5),
      SplashCubit.cubit(context).iniApp,
    );
    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashGoHome) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            state.authed ? Routes.homeAuthedRoute : Routes.homeRoute,
            (route) {
              return false;
            },
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: AnimatedContainer(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImagesAssets.image1,
                ),
                fit: BoxFit.cover,
              ),
            ),
            duration: const Duration(seconds: 1),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DoubleText(
                  title: AppStrings.welcomed,
                ),
                SizedBox(
                  height: AppSize.s12,
                ),
                DoubleText(title: AppStrings.appName),
              ],
            ),
          ),
        );
      },
    );
  }
}
