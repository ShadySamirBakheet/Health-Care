import 'package:flutter/material.dart';
import 'package:health_care_flutter/core/resources/strings_manager.dart';
import 'package:health_care_flutter/features/auth/presentation/pages/change_password.dart';
import 'package:health_care_flutter/features/auth/presentation/pages/forgot_password.dart';
import 'package:health_care_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:health_care_flutter/features/auth/presentation/pages/sign_up_page.dart';
import 'package:health_care_flutter/features/home/presentation/pages/home_page.dart';
import 'package:health_care_flutter/features/home/presentation/pages/my_home_page.dart';
import 'package:health_care_flutter/features/patient/presentation/pages/add_patient_page.dart';
import 'package:health_care_flutter/features/patient/presentation/pages/patient_details.dart';
import 'package:health_care_flutter/features/splash/presentation/pages/splash_page.dart';

class Routes {
  static const String initRoute = splashRoute;
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String forgotPasswordRoute = '/login/forgot-password';
  static const String changePasswordRoute = '/login/change-password';
  static const String signUpRoute = '/signUp';
  static const String homeRoute = '/home';
  static const String homeAuthedRoute = '/home/authed';
  static const String addPatientRoute = '/home/add-patient';
  static const String editPatientRoute = '/home/edit-patient';
  static const String viewPatientRoute = '/home/view-patient';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
          settings: routeSettings,
        );
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (_) => const MyHomePage(),
          settings: routeSettings,
        );
      case Routes.homeAuthedRoute:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: routeSettings,
        );
      case Routes.addPatientRoute:
        return MaterialPageRoute(
          builder: (_) => const AddPatientPage(),
          settings: routeSettings,
        );
      case Routes.editPatientRoute:
        final paientId = routeSettings.arguments;

        return MaterialPageRoute(
          builder: (_) => AddPatientPage(
            isEdit: true,
            paientId: paientId as int?,
          ),
          settings: routeSettings,
        );
      case Routes.viewPatientRoute:
        final paientId = routeSettings.arguments;
        return MaterialPageRoute(
          builder: (_) => PatientDetailsPage(
            paientId: (paientId as int?) ?? 0,
          ),
          settings: routeSettings,
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: routeSettings,
        );
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordPage(),
          settings: routeSettings,
        );
      case Routes.changePasswordRoute:
        return MaterialPageRoute(
          builder: (_) => const ChangePasswordPage(),
          settings: routeSettings,
        );
      case Routes.signUpRoute:
        return MaterialPageRoute(
          builder: (_) => const SignUpPage(),
          settings: routeSettings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => unDefinedRoute(),
          settings: routeSettings,
        );
    }
  }

  static Widget unDefinedRoute() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.noRouteFound),
      ),
      body: const Center(child: Text(AppStrings.noRouteFound)),
    );
  }
}
