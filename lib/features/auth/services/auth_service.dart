import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  AuthService({required this.firestore, required this.auth});

  Future<void> register(String? email, String? password, String? name,
      String? phone, String? role) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      User? user = userCredential.user;
      if (user != null) {
        // Store user details in Firestore
        await firestore.collection('users').doc(user.uid).set({
          'name': name,
          'phone': phone,
          'email': email,
          'role': role,
        });
        log('User registered successfully: ${user.uid}',
            name: 'AuthService.register');
      } else {
        log('User registration failed: User is null',
            name: 'AuthService.register');
        throw Exception('User registration failed');
      }
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthError(e);
    } on FirebaseException catch (e) {
      log('FirebaseException: ${e.message}', name: 'AuthService.register');
      throw Exception('An error occurred while registering. Please try again.');
    } on SocketException catch (e) {
      log('Network Error: ${e.message}', name: 'AuthService.register');
      throw Exception('Network error: Please check your internet connection.');
    } catch (e) {
      log('Unknown error: $e', name: 'AuthService.register');
      throw Exception('An unknown error occurred.');
    }
  }

  void _handleFirebaseAuthError(FirebaseAuthException e) {
    log('FirebaseAuthException: ${e.message}', name: 'AuthService.register');
    switch (e.code) {
      case 'email-already-in-use':
        throw Exception('This email is already in use.');
      case 'weak-password':
        throw Exception('The password provided is too weak.');
      case 'invalid-email':
        throw Exception('The email address is invalid.');
      default:
        throw Exception('Registration failed. Please try again.');
    }
  }
}
