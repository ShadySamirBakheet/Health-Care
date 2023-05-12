import 'package:get_it/get_it.dart';
import 'package:health_care_flutter/core/data/cache/cache_helper.dart';
import 'package:health_care_flutter/core/data/cache/cache_helper_impl.dart';
import 'package:health_care_flutter/features/auth/data/repositories/user_repository.dart';
import 'package:health_care_flutter/features/auth/domain/repositories/user_repository.dart';
import 'package:health_care_flutter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:health_care_flutter/features/home/presentation/cubit/home_cubit.dart';
import 'package:health_care_flutter/features/patient/data/repositories/patient_repository.dart';
import 'package:health_care_flutter/features/patient/domain/repositories/patient_repository.dart';
import 'package:health_care_flutter/features/patient/presentation/cubit/patient_cubit.dart';
import 'package:health_care_flutter/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt
    //!core
    ..registerLazySingleton<CacheHelper>(
      () => CacheHelperIpml(
        sharedPreferences: sharedPreferences,
      ),
    )

    //!Ueer
    ..registerLazySingleton<UserRepository>(
      () => UserRepositoryIpml(cacheHelper: getIt<CacheHelper>()),
    )
    ..registerLazySingleton<AuthCubit>(
      () => AuthCubit(getIt<UserRepository>()),
    )

    //!splash
    ..registerLazySingleton<SplashCubit>(
      () => SplashCubit(getIt<UserRepository>()),
    )

    //!patient
    ..registerLazySingleton<PatientRepository>(
      PatientRepositoryImpl.new,
    )
    ..registerLazySingleton<PatientCubit>(
      () => PatientCubit(getIt<PatientRepository>()),
    )

    //!home
    ..registerLazySingleton<HomeCubit>(
      () => HomeCubit(getIt<PatientRepository>()),
    );
}
