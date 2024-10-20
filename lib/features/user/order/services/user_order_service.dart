

import 'dart:developer';

import 'package:car_workshop_app/constants/app_constants.dart';
import 'package:car_workshop_app/features/user/order/models/order_model.dart';
import 'package:car_workshop_app/features/user/order/models/order_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserOrderService {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  UserOrderService({required this.firestore, required this.auth});

  Future<List<OrderModel>> fetchRunningOrders() async {
    final runningSnapshot = await firestore
        .collection(AppConstants.collectionOrders)
        .where('orderStatus', whereIn: [OrderStatus.pending.name, OrderStatus.processing.name])
        .get();

    return runningSnapshot.docs
        .map((doc) => OrderModel.fromMap(doc.data()))
        .toList()
      ..sort((a, b) => b.orderPlacedDateTime!.compareTo(a.orderPlacedDateTime!));
  }

  Future<List<OrderModel>> fetchCompletedOrders() async {
    final historySnapshot = await firestore
        .collection(AppConstants.collectionOrders)
        .where('orderStatus', whereIn: [OrderStatus.completed.name, OrderStatus.cancelled.name])
        .get();

    return historySnapshot.docs
        .map((doc) => OrderModel.fromMap(doc.data()))
        .toList()
      ..sort((a, b) => b.orderPlacedDateTime!.compareTo(a.orderPlacedDateTime!));
  }

  Future<OrderModel?> fetchOrderById(String orderId) async {
    try {
      final orderSnapshot = await firestore
          .collection(AppConstants.collectionOrders)
          .where('orderId', isEqualTo: orderId)
          .get();
      if (orderSnapshot.docs.isNotEmpty) {
        return OrderModel.fromMap(orderSnapshot.docs.first.data());
      } else {
        log('Order not found for orderId: $orderId');
        return null;
      }
    } catch (e) {
      log('Error fetching order: $e');
      return null;
    }
  }


}