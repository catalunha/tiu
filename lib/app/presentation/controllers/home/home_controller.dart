import 'package:get/get.dart';
import 'package:tiu/app/domain/usecases/auth/auth_usecase.dart';
import 'package:tiu/app/routes.dart';

class HomeController extends GetxController {
  final AuthUseCase _authUseCase;

  HomeController({required AuthUseCase authUseCase})
      : _authUseCase = authUseCase;

  Future<void> logout() async {
    print('em home logout ');
    await _authUseCase.logout();
    Get.offAllNamed(Routes.authLogin);
  }
}
