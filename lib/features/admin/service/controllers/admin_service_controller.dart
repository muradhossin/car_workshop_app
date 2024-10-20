
import 'dart:io';

import 'package:car_workshop_app/core/utils.dart';
import 'package:car_workshop_app/features/admin/service/models/service_model.dart';
import 'package:car_workshop_app/features/admin/service/services/admin_service_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminServiceController extends GetxController implements GetxService {
  final AdminServiceService adminServiceService;
  AdminServiceController({required this.adminServiceService});

  bool isLoading = false;

  Future<void> createService(String name, String description, double price, XFile? image) async {
    if (name.isEmpty || description.isEmpty || price <= 0 || image == null) {
      showCustomSnacker('error', 'Please fill all fields', isError: true);
      return;
    }

    isLoading = true;
    update();

    try {
      String serviceId = adminServiceService.generateServiceId();
      String? imageUrl = await adminServiceService.uploadImage(File(image.path));

      if (imageUrl != null) {
        ServiceModel service = ServiceModel(
          id: serviceId,
          name: name,
          description: description,
          imageUrl: imageUrl,
          price: price,
        );

        await adminServiceService.createService(service);
        showCustomSnacker('success', 'Service created successfully', isError: false);
      }
    } catch (e) {
      showCustomSnacker('error', 'An error occurred: $e', isError: true);
    } finally {
      isLoading = false;
      update();
    }
  }


}