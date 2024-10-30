import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/app_images.dart';
import 'package:caspro_enterprises/Utils/local_shared_preferences.dart';
import 'package:caspro_enterprises/Utils/routes_names.dart';
import 'package:caspro_enterprises/Widgets/common_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      bool isLogin = await LocalPreferences().getLoginBool() ?? false;

      if (isLogin) {
        Get.offAllNamed(RouteNames.adminHomeScreen);
      } else {
        Get.offAllNamed(RouteNames.loginScreen);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            AppImages.appLogo,
            width: double.infinity,
          ),
          const CommonLoader(),
          const SizedBox(
            height: 20,
          ),
        ],
      )),
    );
  }
}
