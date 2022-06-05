import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiu/app/domain/models/milestones_equals_calcs_model.dart';
import 'package:tiu/app/presentation/controllers/milestone/milestone_controller.dart';

class MilestoneEqualsCalcsInfo extends StatelessWidget {
  final MilestoneController _milestoneController = Get.find();

  final MilestonesEqualsCalcsModel calcs;
  MilestoneEqualsCalcsInfo({Key? key, required this.calcs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // _milestoneController.edit(calcs.id!);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Comparativo: ${calcs.idMy} | ${calcs.idOther}'),
              Text(calcs.name),
              Text('${calcs.utmx} | ${calcs.utmy}'),
              Text('${calcs.lat} | ${calcs.long}'),
              Text(
                  '${calcs.utmz} | ${calcs.utmfuso} | ${calcs.utmzone} | ${calcs.utmpole}'),
              Wrap(
                children: [
                  IconButton(
                    tooltip: 'Copiar os dados para meu marco',
                    onPressed: () => _milestoneController
                        .updateMyMilestoneWithOther(calcs.idMy, calcs.idOther),
                    icon: const Icon(Icons.copy),
                  ),
                  IconButton(
                    tooltip: 'Apagar meu marco',
                    onPressed: () => _milestoneController.delete(calcs.idMy),
                    icon: const Icon(
                      Icons.person_off,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Apagar marco do outro',
                    onPressed: () => _milestoneController.delete(calcs.idOther),
                    icon: const Icon(
                      Icons.person_off_outlined,
                      color: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
