import 'dart:convert';

class UserProfileModel {
  final String? id;
  final String? photo;
  final String? nickname;
  final String? fullName;
  final String? description;
  final String? phone;
  final String? email;
  final String? sector;
  final String? position;
  final String? activity;
  UserProfileModel({
    this.id,
    this.photo,
    this.nickname,
    this.fullName,
    this.description,
    this.phone,
    this.email,
    this.sector,
    this.position,
    this.activity,
  });

  UserProfileModel copyWith({
    String? id,
    String? photo,
    String? nickname,
    String? fullName,
    String? description,
    String? phone,
    String? email,
    String? sector,
    String? position,
    String? activity,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      photo: photo ?? this.photo,
      nickname: nickname ?? this.nickname,
      fullName: fullName ?? this.fullName,
      description: description ?? this.description,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      sector: sector ?? this.sector,
      position: position ?? this.position,
      activity: activity ?? this.activity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'photo': photo,
      'nickname': nickname,
      'fullName': fullName,
      'description': description,
      'phone': phone,
      'email': email,
      'sector': sector,
      'position': position,
      'activity': activity,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id'],
      photo: map['photo'],
      nickname: map['nickname'],
      fullName: map['fullName'],
      description: map['description'],
      phone: map['phone'],
      email: map['email'],
      sector: map['sector'],
      position: map['position'],
      activity: map['activity'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserProfileModel(id: $id, photo: $photo, nickname: $nickname, fullName: $fullName, description: $description, phone: $phone, email: $email, sector: $sector, position: $position, activity: $activity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserProfileModel &&
        other.id == id &&
        other.photo == photo &&
        other.nickname == nickname &&
        other.fullName == fullName &&
        other.description == description &&
        other.phone == phone &&
        other.email == email &&
        other.sector == sector &&
        other.position == position &&
        other.activity == activity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        photo.hashCode ^
        nickname.hashCode ^
        fullName.hashCode ^
        description.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        sector.hashCode ^
        position.hashCode ^
        activity.hashCode;
  }
}
