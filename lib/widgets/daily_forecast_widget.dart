import 'package:app_previsao_do_tempo/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_previsao_do_tempo/models/daily_forecast_data.dart';

class DailyForecastWidget extends StatelessWidget {
  final List<DailyForecast> daily;
  const DailyForecastWidget({Key? key, required this.daily}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: daily.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final d = daily[i];
          final weekday = DateFormat.E('pt_BR').format(d.date);
          final icon = Utils.getWeatherIconFromCode(d.weatherCode);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$weekday\n${DateFormat('dd/MM').format(d.date)}',
                textAlign: TextAlign.center,
              ),
              Icon(icon),
              SizedBox(height: 4),
              Text(
                '↑${d.maxTemp.toStringAsFixed(0)}° ↓${d.minTemp.toStringAsFixed(0)}°',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.water_drop, size: 16, color: Colors.blue),
                  const SizedBox(width: 4),
                  Text('${d.precipitationProbability}%'),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
