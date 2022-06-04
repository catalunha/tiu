import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiu/app/presentation/controllers/milestone/milestone_controller.dart';
import 'package:tiu/app/presentation/views/milestone/equals/parts/milestone_equals_list.dart';
import 'package:tiu/app/presentation/views/utils/app_appbar.dart';

class MilestoneEqualsListPage extends StatelessWidget {
  final MilestoneController _milestoneController = Get.find();
  MilestoneEqualsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        title: const Text('Comparando marcos'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => MilestoneEqualsList(
                  milestones: _milestoneController.milestoneEquals,
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
