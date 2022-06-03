import 'package:get/get.dart';
import 'package:tiu/app/data/datasources/back4app/user/profile/user_profile_repository_b4a.dart';
import 'package:tiu/app/data/datasources/repositories/user_profile_repository.dart';
import 'package:tiu/app/domain/usecases/user/profile/user_profile_usecase.dart';
import 'package:tiu/app/domain/usecases/user/profile/user_profile_usecase_impl.dart';
import 'package:tiu/app/presentation/controllers/user/profile/user_profile_controller.dart';

class UserProfileDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<UserProfileRepository>(
      UserProfileRepositoryB4a(),
    );
    Get.put<UserProfileUseCase>(
      UserProfileUseCaseImpl(userProfileRepository: Get.find()),
    );
    Get.lazyPut<UserProfileController>(
      () => UserProfileController(
        userProfileUseCase: Get.find(),
      ),
    );
  }
}
