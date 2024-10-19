import 'dart:developer';

import 'package:car_workshop_app/base_widgets/custom_button_widget.dart';
import 'package:car_workshop_app/base_widgets/custom_textfield_widget.dart';
import 'package:car_workshop_app/features/auth/controllers/auth_controller.dart';
import 'package:car_workshop_app/features/auth/models/user_role.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Get.find<AuthController>().registrationTextControllerInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: GetBuilder<AuthController>(builder: (authController) {
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      controller: authController.nameController,
                      labelText: 'Name',
                      hintText: 'Enter your name',
                      icon: Icons.person,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextField(
                      controller: authController.registrationEmailController,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      icon: Icons.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextField(
                      controller: authController.phoneController,
                      labelText: 'Phone',
                      hintText: 'Enter your phone number',
                      icon: Icons.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextField(
                      controller: authController.registrationPasswordController,
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
                    const SizedBox(height: 16.0),
                    CustomTextField(
                      controller:
                          authController.registrationConfirmPasswordController,
                      labelText: 'Confirm Password',
                      hintText: 'Re-enter your password',
                      icon: Icons.lock,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value !=
                            authController
                                .registrationPasswordController?.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: authController.selectedRole,
                      items: [
                        DropdownMenuItem(
                          value: UserRole.user.name,
                          child: Row(
                            children: const [
                              Icon(Icons.person, color: Colors.blue),
                              SizedBox(width: 8.0),
                              Text('User'),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: UserRole.mechanic.name,
                          child: Row(
                            children: const [
                              Icon(Icons.build, color: Colors.orange),
                              SizedBox(width: 8.0),
                              Text('Mechanic'),
                            ],
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        log('Selected Role: $value');
                        authController.updateSelectedRole(value ?? 'user');
                      },
                      decoration: const InputDecoration(
                        labelText: 'Select Role',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                      ),
                      icon: const Icon(Icons.arrow_drop_down),
                      dropdownColor: Colors.white,
                    ),
                    const SizedBox(height: 16.0),
                    CustomButtonWidget(
                      isLoading: authController.isLoading,
                      text: 'Register',
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          authController.register();
                        }
                      },
                    )
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
    Get.find<AuthController>().disposeRegistrationTextControllers();
    super.dispose();
  }
}
