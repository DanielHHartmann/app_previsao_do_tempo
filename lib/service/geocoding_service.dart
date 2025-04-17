import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:app_previsao_do_tempo/models/place_data.dart';
import 'package:http/http.dart' as http;

class GeocodingService {
  final http.Client _client;
  static const _geocodingBase =
      'https://geocoding-api.open-meteo.com/v1/search';
  GeocodingService({required http.Client client}) : _client = client;
  Future<List<PlaceData>> searchLocation({
    required String name,
    String? countryCode,
    int count = 10,
    String language = 'pt',
  }) async {
    final queryParameters = {
      'name': name,
      'count': count.toString(),
      'language': language,
    };
    if (countryCode != null && countryCode.isNotEmpty) {
      queryParameters['countryCode'] = countryCode;
    }

    log('Realizando busca por locais.');

    final uri = Uri.parse(
      _geocodingBase,
    ).replace(queryParameters: queryParameters);
    final res = await _client.get(uri);

    if (res.statusCode != 200) {
      log('Erro ${res.statusCode} ao buscar localização para "$name".');
      throw Exception(
        'Erro ${res.statusCode} ao buscar localização para "$name".',
      );
    }

    log('Busca por locais realizada com sucesso.');

    final body = json.decode(res.body) as Map<String, dynamic>;
    final results = body['results'] as List<dynamic>?;

    if (results == null) {
      return [];
    }

    return results
        .cast<Map<String, dynamic>>()
        .map((json) => PlaceData.fromJson(json))
        .toList();
  }
}
