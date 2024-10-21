import 'dart:developer';

import 'package:car_workshop_app/constants/app_constants.dart';
import 'package:car_workshop_app/features/auth/models/user_model.dart';
import 'package:car_workshop_app/features/user/order/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminOrderService {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  AdminOrderService({required this.firestore, required this.auth});

  Stream<List<OrderModel>> streamLatestOrders() {
    return firestore
        .collection(AppConstants.collectionOrders)
        .orderBy('orderPlacedDateTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => OrderModel.fromMap(doc.data()))
        .toList());
  }

  Stream<OrderModel?> fetchOrderById(String orderId) {
    return firestore
        .collection(AppConstants.collectionOrders)
        .where('orderId', isEqualTo: orderId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return OrderModel.fromMap(snapshot.docs.first.data());
      } else {
        log('Order not found for orderId: $orderId');
        return null;
      }
    });
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      final querySnapshot = await firestore
          .collection(AppConstants.collectionOrders)
          .where('orderId', isEqualTo: orderId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;

        await firestore
            .collection(AppConstants.collectionOrders)
            .doc(doc.id)
            .update({'orderStatus': newStatus});
      } else {
        throw Exception('Order not found');
      }
    } catch (e) {
      log('Error updating order status: $e', name: 'AdminOrderService.updateOrderStatus');
      throw Exception('Error updating order status. Please try again.');
    }
  }

  Future<void> assignMechanic(String orderId, UserModel mechanic) async {
    try {
      final querySnapshot = await firestore
          .collection(AppConstants.collectionOrders)
          .where('orderId', isEqualTo: orderId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;

        await firestore
            .collection(AppConstants.collectionOrders)
            .doc(doc.id)
            .update({'assignedMechanic': mechanic.toMap()});
      } else {
        throw Exception('Order not found');
      }
    } catch (e) {
      log('Error assigning mechanic: $e', name: 'AdminOrderService.assignMechanic');
      throw Exception('Error assigning mechanic. Please try again.');
    }
  }



}