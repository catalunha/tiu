import 'package:get/get.dart';
import 'package:tiu/app/data/datasources/back4app/milestone/milestone_repository_b4a.dart';
import 'package:tiu/app/data/datasources/repositories/milestone_repository.dart';
import 'package:tiu/app/domain/usecases/milestone/milestone_usecase.dart';
import 'package:tiu/app/domain/usecases/milestone/milestone_usecase_impl.dart';
import 'package:tiu/app/presentation/controllers/milestone/milestone_controller.dart';

class MilestoneDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<MilestoneRepository>(
      MilestoneRepositoryB4a(),
    );
    Get.put<MilestoneUseCase>(
      MilestoneUseCaseImpl(
        repository: Get.find(),
      ),
    );
    Get.put<MilestoneController>(
        MilestoneController(milestoneUseCase: Get.find()));
  }
}
