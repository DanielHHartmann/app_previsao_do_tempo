import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:app_previsao_do_tempo/models/weather_data.dart';
import 'package:app_previsao_do_tempo/service/weather_service.dart';
import '../widgets/core_weather_widget.dart';
import '../widgets/hourly_chart_widget.dart';
import '../widgets/daily_forecast_widget.dart';
import '../widgets/app_drawer_widget.dart';

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  late Future<WeatherData> _weatherFuture;

  String _currentLocationName = 'Localização atual';
  double? _selectedLat;
  double? _selectedLon;

  @override
  void initState() {
    super.initState();
    _loadByCurrentLocation();
  }

  void _loadByCurrentLocation() {
    setState(() {
      _currentLocationName = 'Localização atual';
      _weatherFuture = _loadWeatherForCurrentLocation();
    });
  }

  Future<WeatherData> _loadWeatherForCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Permissão de localização negada. Ative nas configurações do dispositivo.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Permissão de localização permanentemente negada. Ative nas configurações do dispositivo.');
    }

    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final weatherService = Provider.of<WeatherService>(context, listen: false);
    return weatherService.fetchWeather(
      latitude: pos.latitude,
      longitude: pos.longitude,
    );
  }


  void _onCitySelected(String key, double? lat, double? lon, String name) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _currentLocationName = name;
        _selectedLat = lat;
        _selectedLon = lon;
        _weatherFuture = Provider.of<WeatherService>(
          context,
          listen: false,
        ).fetchWeather(latitude: lat!, longitude: lon!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawerWidget(
        onCitySelected: _onCitySelected,
        onUseCurrentLocation: _loadByCurrentLocation,
      ),
      appBar: AppBar(title: Text(_currentLocationName)),
      body: FutureBuilder<WeatherData>(
        future: _weatherFuture,
        builder: (ctx, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('${snap.error}'));
          }

          final data = snap.data!;

          return RefreshIndicator(
            onRefresh: () async {
              if (_selectedLat != null && _selectedLon != null) {
                setState(() {
                  _weatherFuture = Provider.of<WeatherService>(
                    context,
                    listen: false,
                  ).fetchWeather(
                    latitude: _selectedLat!,
                    longitude: _selectedLon!,
                  );
                });
              } else {
                _loadByCurrentLocation();
              }
              await _weatherFuture;
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CoreWeatherWidget(current: data.current, hourly: data.hourly),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      'Previsão por hora',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  HourlyChartWidget(hourly: data.hourly),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      'Previsão da semana',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  DailyForecastWidget(daily: data.daily),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
