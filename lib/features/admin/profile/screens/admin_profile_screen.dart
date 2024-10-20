import 'package:car_workshop_app/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Profile'),
      ),
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return FutureBuilder(
            future: authController.getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('An error occurred'));
              }
              return  Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.person, size: 100, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(
                          snapshot.data?.name ?? '',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          snapshot.data?.email ?? '',
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Logout'),
                                content: const Text('Are you sure you want to logout?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      authController.logout();
                                    },
                                    child: const Text('Logout'),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text('Logout'),

                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }
}