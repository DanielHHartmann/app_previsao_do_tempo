import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_previsao_do_tempo/service/city_storage_service.dart';
import 'package:app_previsao_do_tempo/theme_provider.dart';

class AppDrawerWidget extends StatelessWidget {
  final void Function(String key, double? lat, double? lon, String name) onCitySelected;
  final VoidCallback onUseCurrentLocation;

  const AppDrawerWidget({
    Key? key,
    required this.onCitySelected,
    required this.onUseCurrentLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = Provider.of<CityStorageService>(context, listen: false);

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: storage.loadCities(),
      builder: (_, snap) {
        final cities = snap.data ?? [];
        final themeProvider = Provider.of<ThemeProvider>(context);

        return Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Theme.of(context).primaryColor],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.cloud, color: Colors.white, size: 40),
                    SizedBox(height: 8),
                    Text(
                      'Previsão do Tempo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              SwitchListTile(
                title: const Text('Tema escuro'),
                secondary: Icon(
                  themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                ),
                value: themeProvider.isDarkMode,
                onChanged: (value) => themeProvider.toggleTheme(value),
              ),

              const Divider(),

              ListTile(
                leading: const Icon(Icons.my_location),
                title: const Text('Usar localização atual'),
                onTap: () {
                  Navigator.pop(context);
                  onUseCurrentLocation();
                },
              ),

              const Divider(),

              Expanded(
                child: ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (_, i) {
                    final c = cities[i];
                    return ListTile(
                      leading: const Icon(Icons.location_city),
                      title: Text(
                        '${c['name']}${c['admin1'] != null ? ', ${c['admin1']}' : ''}',
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () => onCitySelected(
                        c['key'],
                        c['latitude'],
                        c['longitude'],
                        c['name']
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await storage.removeCity(cities, c['key']);
                          if (context.mounted) {
                            (context as Element).markNeedsBuild();
                          }
                        },
                      ),
                    );
                  },
                ),
              ),

              const Divider(),

              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Adicionar cidade'),
                onTap: () async {
                  Navigator.pop(context);
                  final result = await Navigator.pushNamed(context, '/search');

                  if (result is Map<String, dynamic>) {
                    onCitySelected(
                      result['key'],
                      result['latitude'],
                      result['longitude'],
                      result['name'],
                    );
                  }

                },
              ),
            ],
          ),
        );
      },
    );
  }
}
