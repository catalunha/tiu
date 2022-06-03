import 'package:flutter/material.dart';
import 'package:tiu/app/domain/models/milestone_model.dart';
import 'package:tiu/app/presentation/views/milestone/list/parts/milestone_info.dart';

class MilestoneList extends StatelessWidget {
  final List<MilestoneModel> milestones;
  const MilestoneList({
    Key? key,
    required this.milestones,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: milestones.length,
      itemBuilder: (context, index) {
        final milestone = milestones[index];
        return MilestoneInfo(milestone: milestone);
      },
    );
  }
}
