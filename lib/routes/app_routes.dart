import 'package:car_workshop_app/core/auth_middleware.dart';
import 'package:car_workshop_app/features/auth/screens/login_screen.dart';
import 'package:car_workshop_app/features/splash/screens/splash_screen.dart';
import 'package:car_workshop_app/main.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String home = '/';
  static const String splash = '/splash';
  static const String login = '/login';

  static getHomeRoute() => home;
  static getSplashRoute() => splash;
  static getLoginRoute() => login;

  // {List<GetPage<dynamic>>? getPages}
  static List<GetPage<dynamic>> getPages = [
    

    GetPage(
      name: splash,
      page: () =>  SplashScreen(),
    ),

    GetPage(
      name: login,
      page: () =>  LoginScreen(),
    ),

    
    
  ];

}

