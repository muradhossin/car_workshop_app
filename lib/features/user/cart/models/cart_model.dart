import 'package:car_workshop_app/features/admin/service/models/service_model.dart';

class CartModel {
  final String userId;
  final List<ServiceModel> services;

  CartModel({
    required this.userId,
    required this.services,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'services': services.map((service) => service.toMap()).toList(),
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      userId: map['userId'],
      services: List<ServiceModel>.from(map['services']?.map((x) => ServiceModel.fromMap(x))),
    );
  }
}
