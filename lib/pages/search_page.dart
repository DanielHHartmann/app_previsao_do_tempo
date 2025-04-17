import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_previsao_do_tempo/service/geocoding_service.dart';
import 'package:app_previsao_do_tempo/service/city_storage_service.dart';
import 'package:app_previsao_do_tempo/models/place_data.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  List<PlaceData> _results = [];
  bool _isLoading = false;
  String? _error;

  Future<void> _search() async {
    final query = _controller.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
      _results = [];
    });

    try {
      final svc = Provider.of<GeocodingService>(context, listen: false);
      final places = await svc.searchLocation(name: query);
      setState(() {
        _results = places;
      });
    } catch (e) {
      setState(() {
        _error = 'Erro ao buscar: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addCity(PlaceData place) async {
    final storage = Provider.of<CityStorageService>(context, listen: false);
    final cities = await storage.loadCities();
    final key = place.id.toString();
    final newCity = {
      'key': key,
      'name': place.name,
      'latitude': place.latitude,
      'longitude': place.longitude,
    };
    if (!cities.any((c) => c['key'] == key)) {
      cities.add(newCity);
      await storage.saveCities(cities);
      await storage.saveSelectedCity(key);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cidade "${place.name}" adicionada.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cidade "${place.name}" já existe.')),
      );
    }
    Navigator.pop(context, {
      'key': key,
      'latitude': place.latitude,
      'longitude': place.longitude,
      'name': place.name,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar localização')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                labelText: 'Cidade',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _search,
                ),
              ),
              onSubmitted: (_) => _search(),
            ),
            const SizedBox(height: 16),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
            if (_error != null)
              Text(_error!, style: TextStyle(color: Colors.red)),
            if (!_isLoading && _error == null)
              Expanded(
                child:
                    _results.isEmpty
                        ? const Center(
                          child: Text('Nenhuma cidade encontrada.'),
                        )
                        : ListView.separated(
                          itemCount: _results.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (_, i) {
                            final place = _results[i];
                            return ListTile(
                              title: Text(
                                '${place.name}${place.admin1 != null ? ', ${place.admin1}' : ''}',
                              ),
                              subtitle: Text(place.country),
                              onTap: () => _addCity(place),
                            );
                          },
                        ),
              ),
          ],
        ),
      ),
    );
  }
}
