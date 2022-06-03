import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiu/app/presentation/controllers/auth/splash/splash_controller.dart';
import 'package:tiu/app/presentation/controllers/home/home_controller.dart';
import 'package:tiu/app/presentation/views/home/parts/popmenu_user.dart';
import 'package:tiu/app/presentation/views/utils/app_appbar.dart';
import 'package:tiu/app/routes.dart';

class HomePage extends StatefulWidget {
  final SplashController _splashController = Get.find();
  final HomeController _homeController = Get.find();

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppAppbar(
          title: appBarTitle(),
          actions: [
            PopMenuButtonPhotoUser(),
          ],
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () => Get.toNamed(Routes.milestoneList),
              child: const Text('Marcos')),
        ));
  }

  Widget appBarTitle() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bem vindo(a),',
              style: TextStyle(fontSize: 12),
            ),
            Text(widget._splashController.userModel?.profile?.nickname == null
                ? "Atualize seu perfil."
                : widget._splashController.userModel!.profile!.nickname!),
          ],
        ));
  }
}
