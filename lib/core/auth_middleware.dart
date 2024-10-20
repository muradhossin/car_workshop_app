import 'package:car_workshop_app/features/auth/controllers/auth_controller.dart';
import 'package:car_workshop_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!isUserAuthenticated()) {
      return RouteSettings(name: AppRoutes.login);
    }
    return null;
  }

  bool isUserAuthenticated() {
    return Get.find<AuthController>().isLoggedIn();
  }
}