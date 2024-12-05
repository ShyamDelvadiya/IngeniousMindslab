class Airport {
  final String icao;
  final String iata;
  final String name;
  final String city;
  final String state;
  final String country;
  final int elevation;
  final double lat;
  final double lon;
  final String tz;

  Airport({
    required this.icao,
    required this.iata,
    required this.name,
    required this.city,
    required this.state,
    required this.country,
    required this.elevation,
    required this.lat,
    required this.lon,
    required this.tz,
  });

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      icao: json['icao'] ?? '',
      iata: json['iata'] ?? '',
      name: json['name'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      elevation: json['elevation'] ?? 0,
      lat: (json['lat'] ?? 0).toDouble(),
      lon: (json['lon'] ?? 0).toDouble(),
      tz: json['tz'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'icao': icao,
      'iata': iata,
      'name': name,
      'city': city,
      'state': state,
      'country': country,
      'elevation': elevation,
      'lat': lat,
      'lon': lon,
      'tz': tz,
    };
  }
}
