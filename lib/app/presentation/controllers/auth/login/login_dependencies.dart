import 'package:get/get.dart';
import 'package:tiu/app/presentation/controllers/auth/login/login_controller.dart';

class AuthLoginDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(
          authUseCase: Get.find(),
          splashController: Get.find(),
        ));
  }
}
