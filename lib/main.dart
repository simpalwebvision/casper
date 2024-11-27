import 'package:caspro_enterprises/Screens/SplashScreen/splash_screen.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/routes_names.dart';
import 'package:caspro_enterprises/Utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

// import 'Services/firebase_services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryColor, statusBarIconBrightness: Brightness.light));
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) async {
    // await Firebase.initializeApp(
    //         options: DefaultFirebaseOptions.currentPlatform)
    //     .then((value) => runApp(const MyApp()));
    runApp(const MyApp());
  });
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // FirebaseServices().firebaseInitServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        child = EasyLoading.init()(context, child);
        child = MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1)),
            child: child);
        return child;
      },
      title: 'Caspro Enterprises',
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      home: const SplashScreen(),
      navigatorKey: NavigationService.navigatorKey,
      getPages: AppRoute.appRoutes(),
    );
  }
}
