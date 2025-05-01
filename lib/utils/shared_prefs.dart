import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  // Write DATA
  static Future<void> saveUserId(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(key, value);
  }

  // Read Data
  static Future<String> getUserId(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(key)!;
  }

  // Remove Data
  static Future<void> removeUserId(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
