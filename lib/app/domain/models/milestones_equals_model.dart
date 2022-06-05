import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:tiu/app/domain/models/milestone_model.dart';
import 'package:tiu/app/domain/models/milestones_equals_calcs_model.dart';

class MilestonesEqualsModel {
  final String? id;
  final List<MilestoneModel> milestonesEquals;
  final List<MilestonesEqualsCalcsModel> milestonesEqualsCalcs;
  MilestonesEqualsModel({
    this.id,
    required this.milestonesEquals,
    required this.milestonesEqualsCalcs,
  });

  MilestonesEqualsModel copyWith({
    String? id,
    List<MilestoneModel>? milestonesEquals,
    List<MilestonesEqualsCalcsModel>? milestonesEqualsCalcs,
  }) {
    return MilestonesEqualsModel(
      id: id ?? this.id,
      milestonesEquals: milestonesEquals ?? this.milestonesEquals,
      milestonesEqualsCalcs:
          milestonesEqualsCalcs ?? this.milestonesEqualsCalcs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'milestonesEquals': milestonesEquals.map((x) => x.toMap()).toList(),
      'milestonesEqualsCalcs':
          milestonesEqualsCalcs.map((x) => x.toMap()).toList(),
    };
  }

  factory MilestonesEqualsModel.fromMap(Map<String, dynamic> map) {
    return MilestonesEqualsModel(
      id: map['id'],
      milestonesEquals: List<MilestoneModel>.from(
          map['milestonesEquals']?.map((x) => MilestoneModel.fromMap(x))),
      milestonesEqualsCalcs: List<MilestonesEqualsCalcsModel>.from(
          map['milestonesEqualsCalcs']
              ?.map((x) => MilestonesEqualsCalcsModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MilestonesEqualsModel.fromJson(String source) =>
      MilestonesEqualsModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'MilestonesEqualsModel(id: $id, milestonesEquals: $milestonesEquals, milestonesEqualsCalcs: $milestonesEqualsCalcs)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MilestonesEqualsModel &&
        other.id == id &&
        listEquals(other.milestonesEquals, milestonesEquals) &&
        listEquals(other.milestonesEqualsCalcs, milestonesEqualsCalcs);
  }

  @override
  int get hashCode =>
      id.hashCode ^ milestonesEquals.hashCode ^ milestonesEqualsCalcs.hashCode;
}
