import 'dart:convert';

import 'package:tiu/app/domain/models/user_model.dart';

class MilestoneModel {
  final String? id;
  final UserModel user;
  final String name;
  final num? utmx;
  final num? utmy;
  final num? utmz;
  final String? utmfuso;
  final String? utmzone;
  final String? utmpole;
  final num? lat;
  final num? long;
  MilestoneModel({
    this.id,
    required this.user,
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

  MilestoneModel copyWith({
    String? id,
    UserModel? user,
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
    return MilestoneModel(
      id: id ?? this.id,
      user: user ?? this.user,
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
      'id': id,
      'user': user.toMap(),
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

  factory MilestoneModel.fromMap(Map<String, dynamic> map) {
    return MilestoneModel(
      id: map['id'],
      user: UserModel.fromMap(map['user']),
      name: map['name'] ?? '',
      utmx: map['utmx']?.toDouble(),
      utmy: map['utmy']?.toDouble(),
      utmz: map['utmz']?.toDouble(),
      utmfuso: map['utmfuso'],
      utmzone: map['utmzone'],
      utmpole: map['utmpole'],
      lat: map['lat']?.toDouble(),
      long: map['long']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MilestoneModel.fromJson(String source) =>
      MilestoneModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MilestoneModel(id: $id, user: $user, name: $name, utmx: $utmx, utmy: $utmy, utmz: $utmz, utmfuso: $utmfuso, utmzone: $utmzone, utmpole: $utmpole, lat: $lat, long: $long)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MilestoneModel &&
        other.id == id &&
        other.user == user &&
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
    return id.hashCode ^
        user.hashCode ^
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
