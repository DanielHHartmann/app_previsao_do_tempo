class HourlyForecast {
  final DateTime time;
  final double temperature;
  final int weatherCode;
  final int precipitationProbability;

  HourlyForecast({
    required this.time,
    required this.temperature,
    required this.weatherCode,
    required this.precipitationProbability,
  });

  factory HourlyForecast.fromJson({
    required int idx,
    required List<int> timestamps,
    required List<num> temps,
    required List<num> codes,
    required List<num> probs,
  }) {
    return HourlyForecast(
      time: DateTime.fromMillisecondsSinceEpoch(timestamps[idx] * 1000),
      temperature: temps[idx].toDouble(),
      weatherCode: codes[idx].toInt(),
      precipitationProbability: probs[idx].toInt(),
    );
  }
}
