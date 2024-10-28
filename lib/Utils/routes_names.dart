import 'package:caspro_enterprises/Screens/Auth/Login/login_screen.dart';
import 'package:get/get.dart';

import '../Screens/Home/home_screen.dart';
import '../Screens/splash_screen.dart';

class RouteNames {
  static const String splashScreen = "/splash_screen";
  static const String loginScreen = "/login_screen";
  static const String homeScreen = "/home_screen";
}

class AppRoute {
  static appRoutes() => [
        GetPage(
            name: RouteNames.splashScreen,
            page: () => const SplashScreen(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),
        GetPage(
            name: RouteNames.loginScreen,
            page: () => const LoginScreen(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),
        GetPage(
            name: RouteNames.homeScreen,
            page: () => const HomeScreen(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),
      ];
}
