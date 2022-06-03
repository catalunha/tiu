import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiu/app/presentation/controllers/auth/splash/splash_controller.dart';
import 'package:tiu/app/presentation/controllers/home/home_controller.dart';
import 'package:tiu/app/routes.dart';

class PopMenuButtonPhotoUser extends StatelessWidget {
  final HomeController _homeController = Get.find();
  final SplashController _splashController = Get.find();

  PopMenuButtonPhotoUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: Offset.fromDirection(120.0, 100.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: TextButton.icon(
              label: const Text('Editar perfil'),
              onPressed: () {
                Get.back();
                Get.toNamed(Routes.userProfile,
                    arguments: _splashController.userModel!.profile);
              },
              icon: const Icon(Icons.person_outline_outlined),
            ),
          ),
          PopupMenuItem(
            child: TextButton.icon(
              label: const Text('Sair'),
              onPressed: () {
                _homeController.logout();
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ),
        ];
      },
      child: Obx(
        () => Tooltip(
          message: 'Click para opções',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: _splashController.userModel?.profile?.photo != null
                ? Image.network(
                    // 'https://parsefiles.back4app.com/ZuF4FI4dZUN4i9ObIoK6LvTuoIuVFNsVAMRjYNkX/0b28345ecb39e2177d1746f80246ed70_woman2.png',
                    _splashController.userModel!.profile!.photo!,
                    height: 40,
                    width: 40,
                    errorBuilder: (_, __, ___) {
                      return const Icon(
                        Icons.person,
                        color: Colors.black,
                      );
                    },
                  )
                : const Align(
                    alignment: Alignment.center,
                    child: Text(
                      '🤪',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
