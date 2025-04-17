import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:app_previsao_do_tempo/models/hourly_forecast_data.dart';

class HourlyChartWidget extends StatelessWidget {
  final List<HourlyForecast> hourly;
  const HourlyChartWidget({Key? key, required this.hourly}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = hourly.take(24).toList();

    final spots =
        data.asMap().entries.map((entry) {
          final i = entry.key;
          final h = entry.value;
          return FlSpot(i.toDouble(), h.temperature);
        }).toList();

    final minTemp =
        data.map((e) => e.temperature).reduce((a, b) => a < b ? a : b) - 2;
    final maxTemp =
        data.map((e) => e.temperature).reduce((a, b) => a > b ? a : b) + 2;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                SizedBox(
                  width: data.length * 60,
                  height: 120,
                  child: LineChart(
                    LineChartData(
                      minY: minTemp,
                      maxY: maxTemp,
                      lineTouchData: LineTouchData(enabled: false),
                      titlesData: FlTitlesData(show: false),
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          color: Colors.orange,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                Colors.orange.withOpacity(0.3),
                                Colors.transparent,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children:
                      data.map((h) {
                        return SizedBox(
                          width: 60,
                          child: Column(
                            children: [
                              Text(
                                '${h.temperature.toStringAsFixed(0)}°',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('${h.time.hour}h'),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.water_drop,
                                    size: 12,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    '${h.precipitationProbability}%',
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
