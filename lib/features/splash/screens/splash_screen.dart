import 'package:car_workshop_app/constants/app_constants.dart';
import 'package:car_workshop_app/core/styles.dart';
import 'package:car_workshop_app/features/auth/controllers/auth_controller.dart';
import 'package:car_workshop_app/features/auth/models/user_model.dart';
import 'package:car_workshop_app/features/auth/models/user_role.dart';
import 'package:car_workshop_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () async {
      final AuthController authController = Get.find<AuthController>();

      if (authController.isLoggedIn()) {
        UserModel? user = await authController.getCurrentUser();
        if (user?.role == UserRole.admin.name) {
          Get.offNamed(AppRoutes.getAdminDashboardRoute());
        } else if (user?.role == UserRole.mechanic.name) {
          Get.offNamed(AppRoutes.getMechanicDashboardRoute());
        } else if (user?.role == UserRole.user.name) {
          Get.offNamed(AppRoutes.getUserDashboardRoute());
        }
      } else {
        Get.offNamed(AppRoutes.getLoginRoute());
      }
    });

    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.car_repair, size: 100, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              AppConstants.appName,
              style: Styles.semiBold,
            ),
          ],
        ),
      ),
    );
  }
}
