import 'package:origin/src/helper/text_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * app_storage.dart
 *
 * @author: Ruoyegz
 * @date: 2021/7/8
 */
class Storage {
  static Future<String?> getString(String key) async {
    if (!TextHelper.isEmpty(key)) {
      SharedPreferences _storage = await SharedPreferences.getInstance();
      return _storage.getString(key);
    }
    return "";
  }

  static void putString(String key, String value) async {
    if (!TextHelper.isEmpty(key)) {
      SharedPreferences _storage = await SharedPreferences.getInstance();
      _storage.setString(key, value);
    }
  }

  static Future<int?> getInt(String key) async {
    if (!TextHelper.isEmpty(key)) {
      SharedPreferences _storage = await SharedPreferences.getInstance();
      return _storage.getInt(key);
    }
    return 0;
  }

  static void putInt(String key, int value) async {
    if (!TextHelper.isEmpty(key)) {
      SharedPreferences _storage = await SharedPreferences.getInstance();
      _storage.setInt(key, value);
    }
  }

  static Future<bool?> getBool(String key) async {
    if (!TextHelper.isEmpty(key)) {
      SharedPreferences _storage = await SharedPreferences.getInstance();
      return _storage.getBool(key);
    }
    return false;
  }

  static void putBool(String key, bool value) async {
    if (!TextHelper.isEmpty(key)) {
      SharedPreferences _storage = await SharedPreferences.getInstance();
      _storage.setBool(key, value);
    }
  }

  static Future<double?> getDouble(String key) async {
    if (!TextHelper.isEmpty(key)) {
      SharedPreferences _storage = await SharedPreferences.getInstance();
      return _storage.getDouble(key);
    }
    return 0.0;
  }

  static void putDouble(String key, double value) async {
    if (!TextHelper.isEmpty(key)) {
      SharedPreferences _storage = await SharedPreferences.getInstance();
      _storage.setDouble(key, value);
    }
  }

  static Future<List<String>?> getStrings(String key) async {
    if (!TextHelper.isEmpty(key)) {
      SharedPreferences _storage = await SharedPreferences.getInstance();
      return _storage.getStringList(key);
    }
    return [];
  }

  static void putStrings(String key, List<String> value) async {
    if (!TextHelper.isEmpty(key)) {
      SharedPreferences _storage = await SharedPreferences.getInstance();
      _storage.setStringList(key, value);
    }
  }

  static Future<Set<String>> getKeys() async {
    SharedPreferences _storage = await SharedPreferences.getInstance();
    return _storage.getKeys();
  }

  static Future<bool> clear() async {
    SharedPreferences _storage = await SharedPreferences.getInstance();
    _storage.clear();
    return true;
  }
}
