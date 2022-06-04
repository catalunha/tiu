import 'package:get/get.dart';
import 'package:tiu/app/presentation/controllers/auth/email/auth_register_email_dependencies.dart';
import 'package:tiu/app/presentation/controllers/auth/login/login_dependencies.dart';
import 'package:tiu/app/presentation/controllers/auth/splash/splash_dependencies.dart';
import 'package:tiu/app/presentation/controllers/home/home_dependencies.dart';
import 'package:tiu/app/presentation/controllers/milestone/milestone_dependencies.dart';
import 'package:tiu/app/presentation/controllers/user/profile/user_profile_dependencies.dart';
import 'package:tiu/app/presentation/views/auth/login/auth_login_page.dart';
import 'package:tiu/app/presentation/views/auth/register/email/auth_register_email.page.dart';
import 'package:tiu/app/presentation/views/auth/splash/splash_page.dart';
import 'package:tiu/app/presentation/views/home/home_page.dart';
import 'package:tiu/app/presentation/views/milestone/append/milestone_append_page.dart';
import 'package:tiu/app/presentation/views/milestone/list/milestone_list_page.dart';
import 'package:tiu/app/presentation/views/milestone/others/milestone_others_list_page.dart';
import 'package:tiu/app/presentation/views/milestone/readfile/milestone_readfile_page.dart';
import 'package:tiu/app/presentation/views/user/profile/user_profile_page.dart';

class Routes {
  static const splash = '/';

  static const authLogin = '/auth/login';
  static const authRegisterEmail = '/auth/register/email';

  static const home = '/home';
  static const userProfile = '/user/profile';

  static const milestoneList = '/milestone/list';
  static const milestoneAppend = '/milestone/append';
  static const milestoneReadFile = '/milestone/readfile';

  static const milestoneOthersList = '/milestone/others/list';

  static final pageList = [
    GetPage(
      name: Routes.splash,
      binding: SplashDependencies(),
      page: () => const SplashPage(),
    ),
    GetPage(
      name: Routes.authLogin,
      binding: AuthLoginDependencies(),
      page: () => AuthLoginPage(),
    ),
    GetPage(
      name: Routes.authRegisterEmail,
      binding: AuthRegisterEmailDependencies(),
      page: () => AuthRegisterEmailPage(),
    ),
    GetPage(
      name: Routes.home,
      binding: HomeDependencies(),
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.userProfile,
      binding: UserProfileDependencies(),
      page: () => UserProfilePage(),
    ),
    GetPage(
      name: Routes.milestoneList,
      binding: MilestoneDependencies(),
      page: () => MilestoneListPage(),
    ),
    GetPage(
      name: Routes.milestoneAppend,
      binding: MilestoneDependencies(),
      page: () => MilestoneAppendPage(),
    ),
    GetPage(
      name: Routes.milestoneReadFile,
      binding: MilestoneDependencies(),
      page: () => MilestoneReadFilePage(),
    ),
    GetPage(
      name: Routes.milestoneOthersList,
      binding: MilestoneDependencies(),
      page: () => MilestoneOthersListPage(),
    ),
  ];
}
