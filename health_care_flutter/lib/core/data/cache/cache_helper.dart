abstract class CacheHelper {
  String? getString(String key);
  int? getint(String key);
  double? getDouble(String key);
  bool? getBoolean(String key);
  Map<String, dynamic>? getMap(String key);
  DateTime? getDateTime(String key);

  Future<bool> removeValue(String key);

  Future setString({required String key, required String value});
  Future setBoolean({required String key, required bool value});
  Future setint({required String key, required int value});
  Future setDouble({required String key, required double value});
  Future setMap({required String key, required Map<String, dynamic> value});
  Future setDateTime({required String key, required DateTime value});
}
