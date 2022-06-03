import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiu/app/presentation/controllers/milestone/milestone_controller.dart';
import 'package:tiu/app/presentation/views/milestone/list/parts/milestone_list.dart';
import 'package:tiu/app/presentation/views/utils/app_appbar.dart';
import 'package:tiu/app/routes.dart';

class MilestoneListPage extends StatelessWidget {
  final MilestoneController _milestoneController = Get.find();
  MilestoneListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        title: const Text('Marcos'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () => Get.toNamed(Routes.milestoneReadFile),
              child: const Text('Ler arquivo')),
          Expanded(
            child: Obx(() => MilestoneList(
                  milestones: _milestoneController.milestones,
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
