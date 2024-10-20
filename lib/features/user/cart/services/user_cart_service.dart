import 'dart:developer';

import 'package:car_workshop_app/constants/app_constants.dart';
import 'package:car_workshop_app/features/user/cart/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserCartService {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  UserCartService({required this.firestore, required this.auth});


  Future<void> saveCart(CartModel cart) async {
    try {
      await firestore.collection(AppConstants.collectionCarts).doc(cart.userId).set(cart.toMap());
    } catch (e) {
      log('Error saving cart: $e');
    }
  }

  Future<CartModel?> getCart() async {
    try {
      DocumentSnapshot doc = await firestore.collection(AppConstants.collectionCarts).doc(auth.currentUser?.uid).get();
      if (doc.exists) {
        return CartModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      log('Error fetching cart: $e');
      return null;
    }
  }

  Future<void> clearCart() async {
    try {
      await firestore.collection(AppConstants.collectionCarts).doc(auth.currentUser?.uid).delete();
    } catch (e) {
      log('Error clearing cart: $e');
    }
  }

  Future<void> removeServiceFromCart(String serviceId) async {
    try {
      CartModel? cart = await getCart();
      if (cart != null) {
        cart.services.removeWhere((service) => service.id == serviceId);
        await saveCart(cart);
      }
    } catch (e) {
      log('Error removing service from cart: $e');
    }
  }
}