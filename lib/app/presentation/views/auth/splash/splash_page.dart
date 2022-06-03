import 'package:flutter/material.dart';

import '../../utils/app_assets.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.logoSplash,
            height: 200,
          ),
          const CircularProgressIndicator(),
        ],
      ),
    ));
  }
}
