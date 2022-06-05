import 'dart:convert';

class MilestonesEqualsCalcsModel {
  final String idMy;
  final String idOther;
  final String name;
  final num? utmx;
  final num? utmy;
  final num? utmz;
  final String? utmfuso;
  final String? utmzone;
  final String? utmpole;
  final num? lat;
  final num? long;
  MilestonesEqualsCalcsModel({
    required this.idMy,
    required this.idOther,
    required this.name,
    this.utmx,
    this.utmy,
    this.utmz,
    this.utmfuso,
    this.utmzone,
    this.utmpole,
    this.lat,
    this.long,
  });

  MilestonesEqualsCalcsModel copyWith({
    String? idMy,
    String? idOther,
    String? name,
    num? utmx,
    num? utmy,
    num? utmz,
    String? utmfuso,
    String? utmzone,
    String? utmpole,
    num? lat,
    num? long,
  }) {
    return MilestonesEqualsCalcsModel(
      idMy: idMy ?? this.idMy,
      idOther: idOther ?? this.idOther,
      name: name ?? this.name,
      utmx: utmx ?? this.utmx,
      utmy: utmy ?? this.utmy,
      utmz: utmz ?? this.utmz,
      utmfuso: utmfuso ?? this.utmfuso,
      utmzone: utmzone ?? this.utmzone,
      utmpole: utmpole ?? this.utmpole,
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idMy': idMy,
      'idOther': idOther,
      'name': name,
      'utmx': utmx,
      'utmy': utmy,
      'utmz': utmz,
      'utmfuso': utmfuso,
      'utmzone': utmzone,
      'utmpole': utmpole,
      'lat': lat,
      'long': long,
    };
  }

  factory MilestonesEqualsCalcsModel.fromMap(Map<String, dynamic> map) {
    return MilestonesEqualsCalcsModel(
      idMy: map['idMy'] ?? '',
      idOther: map['idOther'] ?? '',
      name: map['name'] ?? '',
      utmx: map['utmx'],
      utmy: map['utmy'],
      utmz: map['utmz'],
      utmfuso: map['utmfuso'],
      utmzone: map['utmzone'],
      utmpole: map['utmpole'],
      lat: map['lat'],
      long: map['long'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MilestonesEqualsCalcsModel.fromJson(String source) =>
      MilestonesEqualsCalcsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MilestonesEqualsCalcsModel(idMy: $idMy, idOther: $idOther, name: $name, utmx: $utmx, utmy: $utmy, utmz: $utmz, utmfuso: $utmfuso, utmzone: $utmzone, utmpole: $utmpole, lat: $lat, long: $long)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MilestonesEqualsCalcsModel &&
        other.idMy == idMy &&
        other.idOther == idOther &&
        other.name == name &&
        other.utmx == utmx &&
        other.utmy == utmy &&
        other.utmz == utmz &&
        other.utmfuso == utmfuso &&
        other.utmzone == utmzone &&
        other.utmpole == utmpole &&
        other.lat == lat &&
        other.long == long;
  }

  @override
  int get hashCode {
    return idMy.hashCode ^
        idOther.hashCode ^
        name.hashCode ^
        utmx.hashCode ^
        utmy.hashCode ^
        utmz.hashCode ^
        utmfuso.hashCode ^
        utmzone.hashCode ^
        utmpole.hashCode ^
        lat.hashCode ^
        long.hashCode;
  }
}
