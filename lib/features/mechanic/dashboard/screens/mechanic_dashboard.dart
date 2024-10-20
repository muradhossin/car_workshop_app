import 'package:car_workshop_app/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MechanicDashboard extends StatefulWidget {
  const MechanicDashboard({super.key});

  @override
  State<MechanicDashboard> createState() => _MechanicDashboardState();
}

class _MechanicDashboardState extends State<MechanicDashboard> {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('mechanic Dashboard'),
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