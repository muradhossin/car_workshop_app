import 'dart:developer';

import 'package:car_workshop_app/constants/app_constants.dart';
import 'package:car_workshop_app/features/user/order/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class UserCheckoutService {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  UserCheckoutService({required this.firestore, required this.auth});

  Future<void> placeOrder(OrderModel order) async {
    try {
      final newOrderId = await getNextOrderId();
      final orderWithId = order.copyWith(orderId: newOrderId.toString());
      await firestore.collection(AppConstants.collectionOrders).add(orderWithId.toMap(Get.context!));
    } catch (e) {
      log('Error placing order: $e', name: 'UserCheckoutService');
    }
  }


  Future<int> getNextOrderId() async {
    final orderDocs = await firestore.collection(AppConstants.collectionOrders).get();

    if (orderDocs.docs.isEmpty) {
      return 1000;
    } else {
      int maxOrderId = 1000;
      for (var doc in orderDocs.docs) {
        final orderData = doc.data();
        final orderId = orderData['orderId'] as int?;
        if (orderId != null && orderId > maxOrderId) {
          maxOrderId = orderId;
        }
      }
      return maxOrderId + 1;
    }
  }

}