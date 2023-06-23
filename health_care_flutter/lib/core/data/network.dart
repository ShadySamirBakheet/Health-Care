import 'dart:io';

import 'package:health_care_client/health_care_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

class Network {
  static Client client = Client(
    (!Platform.isAndroid) ? localHost : realHost,
  )..connectivityMonitor = FlutterConnectivityMonitor();

  static String localHost = 'http://localhost:8080/';
  static String realHost = 'https://a3fd-105-182-125-197.ngrok-free.app/';
}
