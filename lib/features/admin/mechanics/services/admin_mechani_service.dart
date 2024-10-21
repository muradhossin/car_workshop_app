import 'package:car_workshop_app/constants/app_constants.dart';
import 'package:car_workshop_app/features/auth/models/user_model.dart';
import 'package:car_workshop_app/features/auth/models/user_role.dart';
import 'package:car_workshop_app/features/mechanic/profile/models/mechanic_status.dart';
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

  Stream<List<UserModel>> getPendingMechanics() {
    return firestore.collection(AppConstants.collectionUsers).where('role', isEqualTo: UserRole.mechanic.name).where('mechanicStatus', isEqualTo: MechanicStatus.pending.name).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
    });
  }

  Stream<List<UserModel>> getApprovedMechanics() {
    return firestore.collection(AppConstants.collectionUsers).where('role', isEqualTo: UserRole.mechanic.name).where('mechanicStatus', isEqualTo: MechanicStatus.approved.name).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
    });
  }

  Stream<List<UserModel>> getRejectedMechanics() {
    return firestore.collection(AppConstants.collectionUsers).where('role', isEqualTo: UserRole.mechanic.name).where('mechanicStatus', isEqualTo: MechanicStatus.rejected.name).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
    });
  }

  Future<void> updateMechanicStatus(UserModel mechanic, String status) async {
    try{
      await firestore.collection(AppConstants.collectionUsers).doc(mechanic.id).update({
        'mechanicStatus': status,
      });
    } catch (e) {
      throw Exception(e);
    }

  }

}