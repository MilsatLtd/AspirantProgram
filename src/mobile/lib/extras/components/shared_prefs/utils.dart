import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static Future<bool> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> removeString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static Future<bool> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<bool> saveInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<bool> saveDouble(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(key, value);
  }

  static Future<double?> getDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  static Future<bool> saveStringList(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, value);
  }

  static Future<List<String>?> getStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }
}

class SecureStorageUtils {
  static Future<void> saveString(String key, String value) async {
    const secureStorage = FlutterSecureStorage();
    return secureStorage.write(key: key, value: value);
  }

  static Future<String?> getString(String key) async {
    const secureStorage = FlutterSecureStorage();
    return secureStorage.read(key: key);
  }

  static Future<void> removeString(String key) async {
    const secureStorage = FlutterSecureStorage();
    return secureStorage.delete(key: key);
  }

  static Future<void> saveInt(String key, int value) async {
    const secureStorage = FlutterSecureStorage();
    return secureStorage.write(key: key, value: value.toString());
  }

  static Future<int?> getInt(String key) async {
    const secureStorage = FlutterSecureStorage();
    return int.tryParse(await secureStorage.read(key: key) ?? '');
  }

  static Future<void> saveDouble(String key, double value) async {
    const secureStorage = FlutterSecureStorage();
    return secureStorage.write(key: key, value: value.toString());
  }

  static Future<double?> getDouble(String key) async {
    const secureStorage = FlutterSecureStorage();
    return double.tryParse(await secureStorage.read(key: key) ?? '');
  }

  static Future<void> saveStringList(String key, List<String> value) async {
    const secureStorage = FlutterSecureStorage();
    return secureStorage.write(key: key, value: jsonEncode(value));
  }

  static Future<List<String>?> getStringList(String key) async {
    const secureStorage = FlutterSecureStorage();
    final value = await secureStorage.read(key: key);
    return value == null ? null : List<String>.from(jsonDecode(value));
  }

  static Future<void> saveDataToStorage<T>(
      String key, T data, String Function(T) toJsonString) async {
    const secureStorage = FlutterSecureStorage();
    final jsonString = toJsonString(data);
    await secureStorage.write(key: key, value: jsonString);
  }

  static Future<T?> getDataFromStorage<T>(
      String key, T Function(String) fromJsonString) async {
    const secureStorage = FlutterSecureStorage();
    final jsonString = await secureStorage.read(key: key);
    if (jsonString != null) {
      return fromJsonString(jsonString);
    }
    return null;
  }

  static Future<void> deleteDataFromStorage(String key) async {
    const secureStorage = FlutterSecureStorage();
    await secureStorage.delete(key: key);
  }
}
