import 'dart:io';
import 'package:car_workshop_app/features/admin/service/controllers/admin_service_controller.dart';
import 'package:car_workshop_app/features/admin/service/widgets/service_form_dialog_widget.dart';
import 'package:car_workshop_app/features/admin/service/widgets/service_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminServiceScreen extends StatelessWidget {
  const AdminServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminServiceController>(
      builder: (adminServiceController) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Manage Services'),
          ),
          body: adminServiceController.isLoading ? const Center(child: CircularProgressIndicator()) : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ServiceViewWidget(),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          floatingActionButton: adminServiceController.isLoading ? null : FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => ServiceFormDialogWidget(),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      }
    );
  }
}



