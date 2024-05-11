import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<SharedPreferences> getPrefsInstance() async {
    return SharedPreferences.getInstance();
  }

  Future<int?> getInt(String key) async {
    SharedPreferences prefs = await getPrefsInstance();
    return prefs.getInt(key);
  }

  Future<bool?> getBool(String key) async {
    SharedPreferences prefs = await getPrefsInstance();
    return prefs.getBool(key);
  }

  Future<void> setInt(String key, int value) async {
    SharedPreferences prefs = await getPrefsInstance();
    await prefs.setInt(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    SharedPreferences prefs = await getPrefsInstance();
    await prefs.setBool(key, value);
  }

  Future<void> deleteKey(String key) async {
    SharedPreferences prefs = await getPrefsInstance();
    await prefs.remove(key);
  }
}
