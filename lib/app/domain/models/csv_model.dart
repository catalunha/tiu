import 'dart:convert';

class CsvModel {
  final String? name;
  final double? utmx;
  final double? utmy;
  final double? utmz;
  final double? lat;
  final double? long;
  CsvModel({
    this.name,
    this.utmx,
    this.utmy,
    this.utmz,
    this.lat,
    this.long,
  });

  CsvModel copyWith({
    String? name,
    double? utmx,
    double? utmy,
    double? utmz,
    double? lat,
    double? long,
  }) {
    return CsvModel(
      name: name ?? this.name,
      utmx: utmx ?? this.utmx,
      utmy: utmy ?? this.utmy,
      utmz: utmz ?? this.utmz,
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'utmx': utmx,
      'utmy': utmy,
      'utmz': utmz,
      'lat': lat,
      'long': long,
    };
  }

  factory CsvModel.fromMap(Map<String, dynamic> map) {
    return CsvModel(
      name: map['name'],
      utmx: map['utmx']?.toDouble(),
      utmy: map['utmy']?.toDouble(),
      utmz: map['utmz']?.toDouble(),
      lat: map['lat']?.toDouble(),
      long: map['long']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CsvModel.fromJson(String source) =>
      CsvModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CsvModel(name: $name, utmx: $utmx, utmy: $utmy, utmz: $utmz, lat: $lat, long: $long)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CsvModel &&
        other.name == name &&
        other.utmx == utmx &&
        other.utmy == utmy &&
        other.utmz == utmz &&
        other.lat == lat &&
        other.long == long;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        utmx.hashCode ^
        utmy.hashCode ^
        utmz.hashCode ^
        lat.hashCode ^
        long.hashCode;
  }
}
