import 'dart:io';

import 'package:car_workshop_app/core/utils.dart';
import 'package:car_workshop_app/features/auth/models/user_model.dart';
import 'package:car_workshop_app/features/auth/models/user_role.dart';
import 'package:car_workshop_app/features/auth/services/auth_service.dart';
import 'package:car_workshop_app/routes/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthService authService;
  AuthController({required this.authService});

  bool isLoading = false;
  bool isPasswordVisible = false;
  String selectedRole = 'user';

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  void updateSelectedRole(String role) {
    selectedRole = role;
    update();
  }

  Future<void> login(String email, String password) async {
    isLoading = true;
    update();

    try {
      if (email.isEmpty || password.isEmpty) {
        throw Exception("All fields are required.");
      }

      UserModel? user = await authService.login(email, password);

      if (user != null) {
        showCustomSnacker(
            'Login successful', 'You have been successfully logged in');
        if (user.role == UserRole.admin.name) {
          Get.offAllNamed(AppRoutes.getAdminDashboardRoute());
        } else if (user.role == UserRole.mechanic.name) {
          Get.offAllNamed(AppRoutes.getMechanicDashboardRoute());
        } else if (user.role == UserRole.user.name) {
          Get.offAllNamed(AppRoutes.getUserDashboardRoute());
        }
      } else {
        showCustomSnacker('Login failed', 'Invalid email or password',
            isError: true);
      }
    } on SocketException {
      showCustomSnacker(
          'Network Error', 'Please check your internet connection.',
          isError: true);
    } catch (e) {
      showCustomSnacker('Error', e.toString(), isError: true);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> register({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    isLoading = true;
    update();
    try {
      String role = selectedRole;

      if (name.isEmpty || phone.isEmpty || email.isEmpty || password.isEmpty) {
        throw Exception("All fields are required.");
      }

      await authService.register(email, password, name, phone, role);

      showCustomSnacker(
          'Registration successful', 'You have been successfully registered');
      Get.offAllNamed(AppRoutes.getLoginRoute());
    } on SocketException {
      showCustomSnacker(
          'Network Error', 'Please check your internet connection.',
          isError: true);
    } catch (e) {
      showCustomSnacker('Error', e.toString(), isError: true);
    } finally {
      isLoading = false;
      update();
    }
  }

  bool isLoggedIn() {
    return authService.isLoggedIn();
  }

  Future<void> logout() async {
    await authService.logout();
    Get.offAllNamed(AppRoutes.getLoginRoute());
    showCustomSnacker('Logout', 'You have been successfully logged out');
  }

  Future<UserModel?> getCurrentUser() {
    return authService.getCurrentUser();
  }
}
