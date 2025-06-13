import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageAdapter {
  Future<void> write(String key, String value);
  Future<String?> read(String key);
  Future<void> delete(String key);
}

class SpLocalStorageAdapterImpl implements LocalStorageAdapter {
  final SharedPreferences sharedPreferences;

  SpLocalStorageAdapterImpl({required this.sharedPreferences});

  @override
  Future<void> write(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  @override
  Future<String?> read(String key) async {
    return sharedPreferences.getString(key);
  }

  @override
  Future<void> delete(String key) async {
    await sharedPreferences.remove(key);
  }
}
