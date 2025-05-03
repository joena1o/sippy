import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static void saveItem(String key, String value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  static void saveBoolItem(String key, bool value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(key, value);
  }

  static void clearItem(String key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }

  static Future<dynamic> getItem(String key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var result = preferences.getString(key);
    return result;
  }

  static Future<dynamic> getBoolItem(String key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var result = preferences.getBool(key);
    return result;
  }

  static Future<void> saveJsonDetails(String key, value) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(key, json.encode(value.toJson()));
  }

  static Future<dynamic> readJsonValue(String key) async {
    final preferences = await SharedPreferences.getInstance();
    var json = preferences.getString(key);
    if (json != null) {
      return jsonDecode(json);
    }
    return null;
  }
}
