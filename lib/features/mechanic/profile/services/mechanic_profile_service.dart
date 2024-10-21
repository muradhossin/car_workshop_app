import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MechanicProfileService {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  MechanicProfileService({required this.firestore, required this.auth});
}