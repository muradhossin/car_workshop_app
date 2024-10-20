

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

  Stream<List<OrderModel>> fetchRunningOrders() {
    return firestore
        .collection(AppConstants.collectionOrders)
        .where('userId', isEqualTo: auth.currentUser?.uid)
        .where('orderStatus', whereIn: [OrderStatus.pending.name, OrderStatus.processing.name])
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => OrderModel.fromMap(doc.data()))
        .toList()
      ..sort((a, b) => b.orderPlacedDateTime!.compareTo(a.orderPlacedDateTime!)));
  }

  Stream<List<OrderModel>> fetchCompletedOrders() {
    return firestore
        .collection(AppConstants.collectionOrders)
        .where('userId', isEqualTo: auth.currentUser?.uid)
        .where('orderStatus', whereIn: [OrderStatus.completed.name, OrderStatus.cancelled.name])
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => OrderModel.fromMap(doc.data()))
        .toList()
      ..sort((a, b) => b.orderPlacedDateTime!.compareTo(a.orderPlacedDateTime!)));
  }

  Stream<OrderModel?> fetchOrderById(String orderId) {
    return firestore
        .collection(AppConstants.collectionOrders)
        .where('orderId', isEqualTo: orderId)
        .where('userId', isEqualTo: auth.currentUser?.uid)
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

  Stream<int> getTotalOrdersCount() {
    return firestore
        .collection(AppConstants.collectionOrders)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Stream<List<OrderModel>> streamLatestOrdersForAdmin() {
    return firestore
        .collection(AppConstants.collectionOrders)
        .orderBy('orderPlacedDateTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => OrderModel.fromMap(doc.data()))
        .toList());
  }
}


