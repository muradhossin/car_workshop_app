import 'package:car_workshop_app/base_widgets/custom_image_view_widget.dart';
import 'package:car_workshop_app/features/admin/service/models/service_model.dart';
import 'package:car_workshop_app/features/admin/service/controllers/admin_service_controller.dart';
import 'package:car_workshop_app/features/admin/service/widgets/service_form_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceViewWidget extends StatelessWidget {
  const ServiceViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminServiceController>(
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
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: SizedBox(
                        width: 50,
                        child: CustomImageViewer(imageUrl: service.imageUrl),
                      ),
                      title: Text(service.name, style: const TextStyle(fontSize: 18), maxLines: 1, overflow: TextOverflow.ellipsis),
                      subtitle: Text(service.description, style: const TextStyle(fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => ServiceFormDialogWidget(service: service),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}