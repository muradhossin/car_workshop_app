import 'package:car_workshop_app/base_widgets/custom_button_widget.dart';
import 'package:car_workshop_app/base_widgets/custom_textfield_widget.dart';
import 'package:car_workshop_app/constants/app_constants.dart';
import 'package:car_workshop_app/constants/dimensions.dart';
import 'package:car_workshop_app/features/auth/controllers/auth_controller.dart';
import 'package:car_workshop_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Get.find<AuthController>().loginTextControllerInit();
  }

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
              child: Form(
                key: _formKey,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!GetUtils.isEmail(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: Dimensions.padding),
                    CustomTextField(
                      controller: authController.passwordController,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      icon: Icons.lock,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: Dimensions.padding * 2),
                    CustomButtonWidget(
                      text: 'Login',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                    ),
                    const SizedBox(height: Dimensions.padding),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.getRegisterRoute());
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
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    Get.find<AuthController>().disposeLoginTextControllers();
    super.dispose();
  }
}
