import 'package:car_workshop_app/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('admin Dashboard'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => authController.logout(),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}