class CurrentWeather {
  final DateTime time;
  final double temperature;
  final int weatherCode;
  final double apparentTemperature;
  final double precipitation;
  final double windSpeed;
  final int windDirection;
  final bool isDay;

  CurrentWeather({
    required this.time,
    required this.temperature,
    required this.weatherCode,
    required this.apparentTemperature,
    required this.precipitation,
    required this.windSpeed,
    required this.windDirection,
    required this.isDay,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      time: DateTime.fromMillisecondsSinceEpoch((json['time'] as int) * 1000),
      temperature: (json['temperature_2m'] as num).toDouble(),
      weatherCode: json['weather_code'] as int,
      apparentTemperature: (json['apparent_temperature'] as num).toDouble(),
      precipitation: (json['precipitation'] as num).toDouble(),
      windSpeed: (json['wind_speed_10m'] as num).toDouble(),
      windDirection: json['wind_direction_10m'] as int,
      isDay: (json['is_day'] as int) == 1,
    );
  }
}
