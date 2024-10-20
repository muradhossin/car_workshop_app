import 'package:car_workshop_app/base_widgets/custom_image_view_widget.dart';
import 'package:car_workshop_app/features/admin/service/models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ServiceViewWidget extends StatelessWidget {
  final List<ServiceModel>? services;

  const ServiceViewWidget({super.key, this.services});

  @override
  Widget build(BuildContext context) {
    return services != null ? ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        final service = services![index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading: CustomImageViewer(imageUrl: service.imageUrl),
            title: Text(service.name, style: const TextStyle(fontSize: 18), maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text(service.description, style: const TextStyle(fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {

              },
            ),
          ),
        );
      },
    ) : const Center(
      child: Text('No services found'),
    );
  }
}