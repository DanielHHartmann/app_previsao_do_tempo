import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CityStorageService {
  static const _citiesKey = 'cities';
  static const _selectedKey = 'selectedCityKey';

  Future<List<Map<String, dynamic>>> loadCities() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_citiesKey);
    if (jsonStr == null) return [];
    return List<Map<String, dynamic>>.from(json.decode(jsonStr));
  }

  Future<String> loadSelectedCity() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedKey) ?? 'current_location';
  }

  Future<void> saveCities(List<Map<String, dynamic>> cities) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_citiesKey, json.encode(cities));
  }

  Future<void> saveSelectedCity(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedKey, key);
  }

  Future<void> removeCity(
    List<Map<String, dynamic>> cities,
    String key, {
    String defaultKey = 'current_location',
  }) async {
    cities.removeWhere((c) => c['key'] == key);
    final prefs = await SharedPreferences.getInstance();
    await saveCities(cities);
    if (key == (await loadSelectedCity())) {
      await saveSelectedCity(defaultKey);
    }
  }
}
