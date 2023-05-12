import 'dart:convert';

import 'package:health_care_flutter/core/data/cache/cache_helper.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelperIpml extends CacheHelper {
  CacheHelperIpml({
    required this.sharedPreferences,
  });
  final SharedPreferences sharedPreferences;

  @override
  DateTime? getDateTime(String key) {
    final time = sharedPreferences.getString(key);

    return DateTime.parse(time ?? '');
  }

  @override
  double? getDouble(String key) {
    return sharedPreferences.getDouble(key);
  }

  @override
  Map<String, dynamic>? getMap(String key) {
    final map = sharedPreferences.getString(key);

    return json.decode(map ?? '') as Map<String, dynamic>;
  }

  @override
  String? getString(String key) {
    return sharedPreferences.getString(key);
  }

  @override
  int? getint(String key) {
    return sharedPreferences.getInt(key);
  }

  @override
  Future setDateTime({required String key, required DateTime value}) async {
    await sharedPreferences.setString(key, DateFormat().format(value));
  }

  @override
  Future setDouble({required String key, required double value}) async {
    await sharedPreferences.setDouble(key, value);
  }

  @override
  Future setMap({
    required String key,
    required Map<String, dynamic> value,
  }) async {
    await sharedPreferences.setString(key, json.encode(value));
  }

  @override
  Future setString({required String key, required String value}) async {
    await sharedPreferences.setString(key, value);
  }

  @override
  Future setint({required String key, required int value}) async {
    await sharedPreferences.setInt(key, value);
  }

  @override
  bool? getBoolean(String key) {
    return sharedPreferences.getBool(key);
  }

  @override
  Future setBoolean({required String key, required bool value}) async {
    await sharedPreferences.setBool(key, value);
  }

  @override
  Future<bool> removeValue(String key) async {
    return sharedPreferences.remove(key);
  }
}
