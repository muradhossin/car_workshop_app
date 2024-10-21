import 'dart:developer';

import 'package:car_workshop_app/constants/app_constants.dart';
import 'package:car_workshop_app/features/user/order/models/order_model.dart';
import 'package:car_workshop_app/features/user/order/models/order_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class MechanicOrderService {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  MechanicOrderService({required this.firestore, required this.auth});


  Stream<int> getTotalOrdersAssignedToMechanic() {
    try {
      return firestore
          .collection(AppConstants.collectionOrders)
          .where('assignedMechanic.id', isEqualTo: auth.currentUser!.uid)
          .snapshots()
          .map((QuerySnapshot querySnapshot) {
        return querySnapshot.size;
      });
    } catch (e) {
      log('Error listening to mechanic orders: $e');
      return Stream.value(0);
    }
  }

  Stream<int> getTodaysOrdersAssignedToMechanic() {
    try {
      DateTime now = DateTime.now();
      DateTime startOfDay = DateTime(now.year, now.month, now.day);
      DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

      String startOfDayStr = startOfDay.toIso8601String();
      String endOfDayStr = endOfDay.toIso8601String();

      return firestore
          .collection(AppConstants.collectionOrders)
          .where('assignedMechanic.id', isEqualTo: auth.currentUser!.uid)
          .where('orderPlacedDateTime', isGreaterThanOrEqualTo: startOfDayStr)
          .where('orderPlacedDateTime', isLessThanOrEqualTo: endOfDayStr)
          .snapshots()
          .map((QuerySnapshot querySnapshot) {
        return querySnapshot.size;
      });
    } catch (e) {
      log('Error listening to mechanic orders: $e');
      return Stream.value(0);
    }
  }

  Stream<List<OrderModel>> getLatestOrders() {
    return firestore
        .collection(AppConstants.collectionOrders)
        .where('assignedMechanic.id', isEqualTo: auth.currentUser!.uid)
        .orderBy('orderPlacedDateTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => OrderModel.fromMap(doc.data()))
        .toList());
  }

  Stream<List<OrderModel>> fetchRunningOrders() {
    return firestore
        .collection(AppConstants.collectionOrders)
        .where('assignedMechanic.id', isEqualTo: auth.currentUser?.uid)
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
        .where('assignedMechanic.id', isEqualTo: auth.currentUser?.uid)
        .where('orderStatus', whereIn: [OrderStatus.completed.name, OrderStatus.cancelled.name])
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => OrderModel.fromMap(doc.data()))
        .toList()
      ..sort((a, b) => b.orderPlacedDateTime!.compareTo(a.orderPlacedDateTime!)));
  }



}