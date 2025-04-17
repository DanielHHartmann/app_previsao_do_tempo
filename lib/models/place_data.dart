class PlaceData {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final double elevation;
  final String featureCode;
  final String countryCode;
  final int? admin1Id;
  final int? admin2Id;
  final int? admin3Id;
  final String timezone;
  final int? population;
  final int? countryId;
  final String country;
  final String? admin1;
  final String? admin2;
  final String? admin3;

  PlaceData({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.elevation,
    required this.featureCode,
    required this.countryCode,
    this.admin1Id,
    this.admin2Id,
    this.admin3Id,
    required this.timezone,
    this.population,
    this.countryId,
    required this.country,
    this.admin1,
    this.admin2,
    this.admin3,
  });

  factory PlaceData.fromJson(Map<String, dynamic> json) {
    int? toInt(dynamic v) => v == null ? null : (v as num).toInt();
    return PlaceData(
      id: toInt(json['id'])!,
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      elevation: (json['elevation'] as num).toDouble(),
      featureCode: json['feature_code'] as String,
      countryCode: json['country_code'] as String,
      admin1Id: toInt(json['admin1_id']),
      admin2Id: toInt(json['admin2_id']),
      admin3Id: toInt(json['admin3_id']),
      timezone: json['timezone'] as String,
      population: toInt(json['population']),
      countryId: toInt(json['country_id']),
      country: json['country'] as String,
      admin1: json['admin1'] as String?,
      admin2: json['admin2'] as String?,
      admin3: json['admin3'] as String?,
    );
  }
}
