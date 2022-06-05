import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiu/app/domain/models/milestone_model.dart';
import 'package:tiu/app/presentation/controllers/milestone/milestone_controller.dart';
import 'package:tiu/app/presentation/views/utils/app_launch.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(milestone.name),
              Text('${milestone.utmx} | ${milestone.utmy}'),
              Text('${milestone.lat} | ${milestone.long}'),
              Text(
                  '${milestone.utmz} | ${milestone.utmfuso} | ${milestone.utmzone} | ${milestone.utmpole}'),
              IconButton(
                onPressed: () =>
                    AppLaunch.launchGoogleMaps(milestone.lat!, milestone.long!),
                icon: const Icon(Icons.location_on),
              )
            ],
          ),
        ),
      ),
    );
  }
}
