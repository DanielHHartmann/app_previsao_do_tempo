import 'package:app_previsao_do_tempo/models/current_weather_data.dart';
import 'package:app_previsao_do_tempo/models/daily_forecast_data.dart';
import 'package:app_previsao_do_tempo/models/hourly_forecast_data.dart';

class WeatherData {
  final CurrentWeather current;
  final List<HourlyForecast> hourly;
  final List<DailyForecast> daily;

  WeatherData({
    required this.current,
    required this.hourly,
    required this.daily,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final current = CurrentWeather.fromJson(json['current']);
    final h = json['hourly'] as Map<String, dynamic>;
    final times = (h['time'] as List).cast<int>();
    final temps = (h['temperature_2m'] as List).cast<num>();
    final codes = (h['weather_code'] as List).cast<num>();
    final probs = (h['precipitation_probability'] as List).cast<num>();

    final hourly = List<HourlyForecast>.generate(
      times.length,
      (i) => HourlyForecast.fromJson(
        idx: i,
        timestamps: times,
        temps: temps,
        codes: codes,
        probs: probs,
      ),
    );

    final d = json['daily'] as Map<String, dynamic>;
    final count = (d['time'] as List).length;
    final daily = List<DailyForecast>.generate(
      count,
      (i) => DailyForecast.fromJson(i, d),
    );

    return WeatherData(current: current, hourly: hourly, daily: daily);
  }
}
