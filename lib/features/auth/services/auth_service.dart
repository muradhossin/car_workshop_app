import 'dart:developer';
import 'dart:io';
import 'package:car_workshop_app/constants/app_constants.dart';
import 'package:car_workshop_app/features/auth/models/user_model.dart';
import 'package:car_workshop_app/features/auth/models/user_role.dart';
import 'package:car_workshop_app/features/mechanic/profile/models/mechanic_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  AuthService({required this.firestore, required this.auth});

  Future<UserModel?> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        DocumentSnapshot userDoc = await firestore
            .collection(AppConstants.collectionUsers)
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          UserModel userModel = UserModel.fromMap(userData);
          return userModel;
        } else {
          throw FirebaseAuthException(
              code: 'no-user-data',
              message: 'User data not found in Firestore');
        }
      }
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw FirebaseAuthException(
            code: 'user-not-found', message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw FirebaseAuthException(
            code: 'wrong-password', message: 'Wrong password provided.');
      } else {
        throw Exception('User not found. Please try again.');
      }
    } catch (e) {
      log('Error during login: $e', name: 'AuthService.login');
      throw Exception('Login failed. Please try again.');
    }
  }

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
        await firestore
            .collection(AppConstants.collectionUsers)
            .doc(user.uid)
            .set({
          'id': user.uid,
          'name': name,
          'phone': phone,
          'email': email,
          'role': role,
          if(role == UserRole.mechanic.name) 'mechanicStatus': MechanicStatus.pending.name,
        });
        log('User registered successfully: ${user.uid}',
            name: 'AuthService.register');
        auth.signOut();
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

  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      log('Error during logout: $e', name: 'AuthService.logout');
      throw Exception('An error occurred while logging out. Please try again.');
    }
  }

  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  Future<UserModel?> getCurrentUser() async {
    User? user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await firestore
          .collection(AppConstants.collectionUsers)
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        UserModel userModel = UserModel.fromMap(userData);
        return userModel;
      }
    }
    return null;
  }
}
