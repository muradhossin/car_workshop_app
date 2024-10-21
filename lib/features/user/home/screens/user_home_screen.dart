import 'package:car_workshop_app/constants/app_constants.dart';
import 'package:car_workshop_app/features/admin/service/controllers/admin_service_controller.dart';
import 'package:car_workshop_app/features/admin/service/widgets/service_view_widget.dart';
import 'package:car_workshop_app/features/user/home/widgets/service_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:car_workshop_app/features/admin/service/models/service_model.dart';
import 'package:get/get.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.appName),
      ),
      body: GetBuilder<AdminServiceController>(
        builder: (adminServiceController) {
          return StreamBuilder<List<ServiceModel>>(
            stream: adminServiceController.getServices(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('An error occurred'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No services found'));
              } else {
                final services = snapshot.data!;
                return ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return ServiceCardWidget(service: service);
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}





