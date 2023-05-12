import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_flutter/app/injection_container.dart';
import 'package:health_care_flutter/core/resources/routes_manager.dart';
import 'package:health_care_flutter/core/resources/theme_manager.dart';
import 'package:health_care_flutter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:health_care_flutter/features/home/presentation/cubit/home_cubit.dart';
import 'package:health_care_flutter/features/patient/presentation/cubit/patient_cubit.dart';
import 'package:health_care_flutter/features/splash/presentation/cubit/splash_cubit.dart';

class HealthCareApp extends StatelessWidget {
  const HealthCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<PatientCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<HomeCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<SplashCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Health Care',
        theme: getApplicationTheme(),
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.initRoute,
      ),
    );
  }
}
