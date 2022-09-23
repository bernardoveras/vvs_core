import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage_service.dart';

class SharedPreferencesLocalStorageService implements ILocalStorageService {
  SharedPreferencesLocalStorageService(this._storage);

  final SharedPreferences _storage;

  @override
  Future<bool> add(String key, dynamic value) async {
    switch (value.runtimeType) {
      case int:
        return await _storage.setInt(key, value);
      case double:
        return await _storage.setDouble(key, value);
      case bool:
        return await _storage.setBool(key, value);
      case List<String>:
        return await _storage.setStringList(key, value);
      case Map<String, dynamic>:
        return await _storage.setString(key, jsonEncode(value));
      case String:
      default:
        return await _storage.setString(key, value.toString());
    }
  }

  @override
  Future<dynamic> read(String key) async {
    return _storage.get(key);
  }

  @override
  Future<bool> delete(String key) async {
    return await _storage.remove(key);
  }

  @override
  Future<bool> deleteAll() async {
    return await _storage.clear();
  }

  @override
  Future<bool> deleteKeys(List<String> keys) async {
    bool result = false;

    for (String key in keys) {
      if (_storage.containsKey(key)) {
        result = await _storage.remove(key);
      }
    }

    return result;
  }
}
