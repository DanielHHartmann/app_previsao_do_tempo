class DailyForecast {
  final DateTime date;
  final int weatherCode;
  final double maxTemp;
  final double minTemp;
  final int precipitationProbability;

  DailyForecast({
    required this.date,
    required this.weatherCode,
    required this.maxTemp,
    required this.minTemp,
    required this.precipitationProbability,
  });

  factory DailyForecast.fromJson(int index, Map<String, dynamic> json) {
    return DailyForecast(
      date: DateTime.fromMillisecondsSinceEpoch(
        (json['time'][index] as int) * 1000,
      ),
      weatherCode: (json['weather_code'][index] as num).toInt(),
      maxTemp: (json['temperature_2m_max'][index] as num).toDouble(),
      minTemp: (json['temperature_2m_min'][index] as num).toDouble(),
      precipitationProbability:
          (json['precipitation_probability_max'][index] as num).toInt(),
    );
  }
}
