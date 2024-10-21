import 'package:car_workshop_app/constants/app_constants.dart';
import 'package:car_workshop_app/features/auth/models/user_role.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminMechanicService {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  AdminMechanicService({required this.firestore, required this.auth});

  Stream<int> getMechanicsCount() {
    return firestore.collection(AppConstants.collectionUsers).where('role', isEqualTo: UserRole.mechanic.name).snapshots().map((snapshot) {
      return snapshot.docs.length;
    });
  }

}