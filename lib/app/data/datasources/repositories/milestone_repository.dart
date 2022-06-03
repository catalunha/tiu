import 'package:get/get.dart';
import 'package:tiu/app/domain/models/milestone_model.dart';

abstract class MilestoneRepository {
  Future<void> list(RxList<MilestoneModel> list);
  Future<void> create(MilestoneModel courseModel);
  Future<void> update(MilestoneModel courseModel);
  Future<void> delete(String id);
}
