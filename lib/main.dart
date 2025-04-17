import 'package:app_previsao_do_tempo/pages/search_page.dart';
import 'package:app_previsao_do_tempo/pages/weather_home_page.dart';
import 'package:app_previsao_do_tempo/service/city_storage_service.dart';
import 'package:app_previsao_do_tempo/service/geocoding_service.dart';
import 'package:app_previsao_do_tempo/service/weather_service.dart';
import 'package:app_previsao_do_tempo/theme_provider.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('pt_BR', null);
  await CountryCodes.init();

  final httpClient = http.Client();
  final weatherService = WeatherService(client: httpClient);
  final geocodingService = GeocodingService(client: httpClient);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // 👈 aqui!
        Provider<http.Client>.value(value: httpClient),
        Provider<WeatherService>.value(value: weatherService),
        Provider<GeocodingService>.value(value: geocodingService),
        Provider<CityStorageService>(create: (_) => CityStorageService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Previsão do Tempo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: WeatherHomePage(),
      routes: {'/search': (_) => const SearchPage()},
    );
  }
}
