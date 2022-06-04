import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiu/app/presentation/controllers/milestone/milestone_controller.dart';
import 'package:tiu/app/presentation/views/milestone/others/parts/milestone_others_list.dart';
import 'package:tiu/app/presentation/views/utils/app_appbar.dart';

class MilestoneOthersListPage extends StatelessWidget {
  final MilestoneController _milestoneController = Get.find();
  MilestoneOthersListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        title: const Text('Marcos dos colegas'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => MilestoneOthersList(
                  milestones: _milestoneController.milestonesOthers,
                )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _milestoneController.add();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
