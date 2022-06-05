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
        title: const Text('Meus marcos'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () => Get.toNamed(Routes.milestoneReadFile),
              child: const Text('Importar novos marcos')),
          ListTile(
            leading: const Icon(Icons.search),
            trailing: Obx(
                () => Text('${_milestoneController.milestoneSearch.length}')),
            title: TextField(
              decoration: const InputDecoration(
                labelText: 'Digite o nome de um marco',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                _milestoneController.onMilestoneSearch(value, true);
              },
            ),
          ),
          Expanded(
            child: Obx(
              () => _milestoneController.milestoneSearch.isNotEmpty
                  ? Card(
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SizedBox(
                          height: 200,
                          child: MilestoneList(
                            milestones: _milestoneController.milestoneSearch,
                          ),
                        ),
                      ),
                    )
                  : MilestoneList(
                      milestones: _milestoneController.milestones,
                    ),
            ),
          ),
          // Expanded(
          //   child: Obx(
          //     () => MilestoneList(
          //       milestones: _milestoneController.milestones,
          //     ),
          //   ),
          // ),
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
