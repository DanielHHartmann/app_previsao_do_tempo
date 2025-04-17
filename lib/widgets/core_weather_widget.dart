import 'package:app_previsao_do_tempo/utils.dart';
import 'package:flutter/material.dart';
import 'package:app_previsao_do_tempo/models/current_weather_data.dart';
import 'package:app_previsao_do_tempo/models/hourly_forecast_data.dart';
class CoreWeatherWidget extends StatelessWidget {
  final CurrentWeather current;
  final List<HourlyForecast> hourly;
  const CoreWeatherWidget({
    Key? key,
    required this.current,
    required this.hourly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final temp = current.temperature.toStringAsFixed(0);
    final feels = current.apparentTemperature.toStringAsFixed(0);
    final icon = Utils.getWeatherIconFromCode(current.weatherCode);
    final desc = Utils.getWeatherDescriptionFromCode(current.weatherCode);
    final windDir = _degToCompass(current.windDirection);

    final now = current.time;
    final match = hourly.firstWhere(
      (h) =>
          h.time.year == now.year &&
          h.time.month == now.month &&
          h.time.day == now.day &&
          h.time.hour == now.hour,
      orElse: () => hourly.first,
    );
    final precipProb = match.precipitationProbability;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            '$temp°',
            style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32),
              const SizedBox(width: 16),
              Text(desc, style: TextStyle(fontSize: 20)),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _infoChip('Sensação', '$feels°'),
              _infoChip('Chuva', '$precipProb%'),
              _infoChip(
                'Precip.',
                '${current.precipitation.toStringAsFixed(1)} mm',
              ),
              _infoChipWithIcon(
                'Vento',
                '${current.windSpeed.toStringAsFixed(0)} km/h',
                current.windDirection.toDouble(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoChip(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _infoChipWithIcon(String label, String value, double direction) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.rotate(
              angle: (direction + 180) * 3.1416 / 180,
              child: Icon(Icons.navigation, size: 16, color: Colors.blue),
            ),
            const SizedBox(width: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }

  String _degToCompass(int deg) {
    const points = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    return points[((deg + 22) ~/ 45) % 8];
  }
}
