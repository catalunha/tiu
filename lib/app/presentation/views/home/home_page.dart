import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiu/app/presentation/controllers/auth/splash/splash_controller.dart';
import 'package:tiu/app/presentation/controllers/home/home_controller.dart';
import 'package:tiu/app/presentation/views/home/parts/popmenu_user.dart';
import 'package:tiu/app/presentation/views/utils/app_appbar.dart';
import 'package:tiu/app/presentation/views/utils/app_assets.dart';
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
        body: Align(
          alignment: Alignment.topCenter,
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            children: [
              itemGrid(
                  image: AppAssets.logoSplash,
                  text: 'Meus Marcos',
                  onTap: () {
                    print('click');
                    Get.toNamed(Routes.milestoneList,
                        arguments: 'myMilestones');
                  }),
              itemGrid(
                image: AppAssets.logoSplash,
                text: 'Outros Marcos',
                onTap: () => Get.toNamed(Routes.milestoneOthersList,
                    arguments: 'OthersMilestones'),
              ),
              itemGrid(
                image: AppAssets.logoSplash,
                text: 'Comparando Marcos',
                onTap: () => Get.toNamed(Routes.milestoneEqualsList,
                    arguments: 'EqualsMilestones'),
              ),
            ],
          ),
        )
        // body: SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       Card(
        //         child: ListTile(
        //           title: const Text(
        //             'Gerenciar meus marcos',
        //           ),
        //           onTap: () => Get.toNamed(Routes.milestoneList,
        //               arguments: 'myMilestones'),
        //         ),
        //       ),
        //       Card(
        //         child: ListTile(
        //           title: const Text(
        //             'Visualizar outros marcos',
        //           ),
        //           onTap: () => Get.toNamed(Routes.milestoneOthersList,
        //               arguments: 'OthersMilestones'),
        //         ),
        //       ),
        //       Card(
        //         child: ListTile(
        //           title: const Text(
        //             'Comparar marcos',
        //           ),
        //           onTap: () => Get.toNamed(Routes.milestoneEqualsList,
        //               arguments: 'EqualsMilestones'),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        );
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

  Container itemGrid(
      {required String image, required String text, Function()? onTap}) {
    return Container(
      width: 200, //WEB=300,
      height: 200,
      // padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.amberAccent,

        // borderRadius: const BorderRadius.only(
        //   topLeft: Radius.circular(20),
        //   bottomLeft: Radius.circular(20),
        // ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.network(
            //   image,
            //   width: 120,
            //   height: 120,
            //   fit: BoxFit.cover,
            // ),
            Image.asset(
              image,
              height: 150,
              width: 100,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              // style: FlutterFlowTheme.of(context).bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
