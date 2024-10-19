import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseFirestore firestore;
  AuthService({required this.firestore});
}