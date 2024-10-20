import 'dart:developer';
import 'dart:io';
import 'package:car_workshop_app/base_widgets/custom_image_view_widget.dart';
import 'package:car_workshop_app/core/utils.dart';
import 'package:car_workshop_app/features/admin/service/controllers/admin_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:car_workshop_app/features/admin/service/models/service_model.dart';
import 'package:get/get.dart';

class ServiceFormDialogWidget extends StatefulWidget {
  final ServiceModel? service;

  const ServiceFormDialogWidget({super.key, this.service});

  @override
  ServiceFormDialogWidgetState createState() => ServiceFormDialogWidgetState();
}

class ServiceFormDialogWidgetState extends State<ServiceFormDialogWidget> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.service != null) {
      nameController.text = widget.service!.name;
      descriptionController.text = widget.service!.description;
      priceController.text = widget.service!.price.toString();
    }
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _image = image;
        });
      }
    } catch (e) {
      showCustomSnacker('error', 'Error picking image: $e', isError: true);
      log('Error picking image: $e', name: 'ServiceFormDialogWidgetState');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          return AlertDialog(
            title: Text(widget.service == null ? 'Add New Service' : 'Edit Service'),
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Service Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a service name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      maxLines: 4,
                      controller: descriptionController,
                      decoration: const InputDecoration(labelText: 'Description'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: priceController,
                      decoration: const InputDecoration(labelText: 'Price'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    if (widget.service != null && widget.service!.imageUrl.isNotEmpty && _image == null)
                      CustomImageViewer(imageUrl: widget.service!.imageUrl, height: 100, width: 200)
                    else if (_image != null)
                      Image.file(
                        File(_image!.path),
                        height: 100,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: pickImage,
                      child: const Text('Select Image'),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.service == null && _image == null) {
                      showCustomSnacker('error', 'Please select an image', isError: true);
                      return;
                    }

                    final adminServiceController = Get.find<AdminServiceController>();

                    if (widget.service == null) {
                      adminServiceController.createService(
                        nameController.text.trim(),
                        descriptionController.text.trim(),
                        double.parse(priceController.text.trim()),
                        _image,
                      );
                    } else {
                      adminServiceController.updateService(
                        widget.service!.id,
                        nameController.text.trim(),
                        descriptionController.text.trim(),
                        double.parse(priceController.text.trim()),
                        _image,
                        serviceModel: widget.service,
                      );
                    }

                    Navigator.of(context).pop();
                  }
                },
                child: Text(widget.service == null ? 'Add' : 'Update'),
              )
            ],
          );
        }
    );
  }
}

