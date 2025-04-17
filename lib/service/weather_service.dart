import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/weather_data.dart';

class WeatherService {
  final http.Client _client;
  static const _openMeteoBase = 'https://api.open-meteo.com/v1/forecast';

  WeatherService({required http.Client client}) : _client = client;

  Future<WeatherData> fetchWeather({
    required double latitude,
    required double longitude,
  }) async {
    final dailyVars = [
      'weather_code',
      'temperature_2m_max',
      'temperature_2m_min',
      'precipitation_probability_max',
    ].join(',');
    final hourlyVars = [
      'temperature_2m',
      'weather_code',
      'precipitation_probability',
    ].join(',');
    final currentVars = [
      'temperature_2m',
      'weather_code',
      'apparent_temperature',
      'precipitation',
      'wind_speed_10m',
      'wind_direction_10m',
      'is_day',
    ].join(',');

    final uri = Uri.parse(_openMeteoBase).replace(
      queryParameters: {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'daily': dailyVars,
        'hourly': hourlyVars,
        'current': currentVars,
        'timezone': 'auto',
        'timeformat': 'unixtime',
      },
    );

    log('Realizando busca por clima.');

    final res = await _client.get(uri);
    if (res.statusCode != 200) {
      log('Erro ${res.statusCode} ao buscar clima.');

      throw Exception('Erro ${res.statusCode} ao buscar clima.');
    }

    log('Busca por clima realizada com sucesso.');

    final body = json.decode(res.body) as Map<String, dynamic>;
    return WeatherData.fromJson(body);
  }
}
