import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_care_flutter/app/injection_container.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(
      bloc,
    );
    print('onCreate(${bloc.runtimeType})');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(
      bloc,
    );
    print('onClose(${bloc.runtimeType})');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('onTransition(${bloc.runtimeType}, $transition)');
    super.onTransition(bloc, transition);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    log('onEvent(${bloc.runtimeType}, $event)');
    super.onEvent(bloc, event);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  FlutterError.onError = (details) {
    log(
      'Dev Mode Error ${details.exceptionAsString()}',
      stackTrace: details.stack,
    );
  };

  await init();
  Bloc.observer = AppBlocObserver();

  await runZonedGuarded(
    () async => runApp(await builder()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
