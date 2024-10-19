import 'package:car_workshop_app/base_widgets/custom_button_widget.dart';
import 'package:car_workshop_app/base_widgets/custom_textfield_widget.dart';
import 'package:car_workshop_app/constants/app_constants.dart';
import 'package:car_workshop_app/constants/dimensions.dart';
import 'package:car_workshop_app/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName + ' - Login'),
        centerTitle: true,
      ),
      body: GetBuilder<AuthController>(builder: (authController) {
        return Padding(
          padding: const EdgeInsets.all(Dimensions.padding),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.car_repair,
                    size: 100,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: Dimensions.padding * 2),
                  CustomTextField(
                    controller: authController.emailController,
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    icon: Icons.email,
                  ),
                  const SizedBox(height: Dimensions.padding),
                  CustomTextField(
                    controller: authController.passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  const SizedBox(height: Dimensions.padding * 2),
                  CustomButtonWidget(
                    text: 'Login',
                    onPressed: () {},
                  ),
                  const SizedBox(height: Dimensions.padding),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/register');
                    },
                    child: const Text(
                      'Don\'t have an account? Register',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    Get.find<AuthController>().emailController.dispose();
    Get.find<AuthController>().passwordController.dispose();
    super.dispose();
  }
}
