import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:tiu/app/domain/models/milestone_model.dart';

class MilestonesEqualsModel {
  final List<MilestoneModel> milestonesEquals;
  MilestonesEqualsModel({
    required this.milestonesEquals,
  });

  MilestonesEqualsModel copyWith({
    List<MilestoneModel>? milestonesEquals,
  }) {
    return MilestonesEqualsModel(
      milestonesEquals: milestonesEquals ?? this.milestonesEquals,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'milestonesEquals': milestonesEquals.map((x) => x.toMap()).toList(),
    };
  }

  factory MilestonesEqualsModel.fromMap(Map<String, dynamic> map) {
    return MilestonesEqualsModel(
      milestonesEquals: List<MilestoneModel>.from(
          map['milestonesEquals']?.map((x) => MilestoneModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MilestonesEqualsModel.fromJson(String source) =>
      MilestonesEqualsModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'MilestonesEqualsModel(milestonesEquals: $milestonesEquals)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MilestonesEqualsModel &&
        listEquals(other.milestonesEquals, milestonesEquals);
  }

  @override
  int get hashCode => milestonesEquals.hashCode;
}
