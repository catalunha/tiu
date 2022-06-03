import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiu/app/domain/models/milestone_model.dart';
import 'package:tiu/app/presentation/controllers/milestone/milestone_controller.dart';

class MilestoneInfo extends StatelessWidget {
  final MilestoneController _milestoneController = Get.find();

  final MilestoneModel milestone;
  MilestoneInfo({Key? key, required this.milestone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _milestoneController.edit(milestone.id!);
      },
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text(milestone.name),
            )
          ],
        ),
      ),
    );
  }
}
