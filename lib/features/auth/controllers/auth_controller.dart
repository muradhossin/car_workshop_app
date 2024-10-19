import 'dart:io';

import 'package:car_workshop_app/core/utils.dart';
import 'package:car_workshop_app/features/auth/services/auth_service.dart';
import 'package:car_workshop_app/routes/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthService authService;
  AuthController({required this.authService});

  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? registrationEmailController;
  TextEditingController? registrationPasswordController;
  TextEditingController? registrationConfirmPasswordController;
  TextEditingController? nameController;
  TextEditingController? phoneController;

  bool isLoading = false;

  void loginTextControllerInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void registrationTextControllerInit() {
    registrationEmailController = TextEditingController();
    registrationPasswordController = TextEditingController();
    registrationConfirmPasswordController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
  }

  void disposeLoginTextControllers() {
    emailController?.dispose();
    passwordController?.dispose();
  }

  void disposeRegistrationTextControllers() {
    registrationEmailController?.dispose();
    registrationPasswordController?.dispose();
    registrationConfirmPasswordController?.dispose();
    nameController?.dispose();
    phoneController?.dispose();
  }

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

  // Future<void> login() async {
  //   isLoading = true;
  //   try {
  //     await authService.login(emailController?.text, passwordController?.text);
  //   } finally {
  //     isLoading = false;
  //   }
  // }

   Future<void> register() async {
    isLoading = true;  
    update();
    try {
      String? name = nameController?.text.trim();
      String? phone = phoneController?.text.trim();
      String? email = registrationEmailController?.text.trim();
      String? password = registrationPasswordController?.text.trim();
      String? role = selectedRole;

      if (email == null || password == null || role == null) {
        throw Exception("All fields are required.");
      }

    
      await authService.register(email, password, name, phone, role);

      showCustomSnacker('Registration successful', 'You have been successfully registered');
      Get.offAllNamed(AppRoutes.getLoginRoute());
      
    } on SocketException {
      showCustomSnacker('Network Error', 'Please check your internet connection.');
    } catch (e) {
      showCustomSnacker('Error', e.toString());
    } finally {
      isLoading = false;  
      update();
    }
  }
}
