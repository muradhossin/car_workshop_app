import 'dart:developer';
import 'dart:io';
import 'package:car_workshop_app/constants/app_constants.dart';
import 'package:car_workshop_app/features/admin/service/models/service_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AdminServiceService {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  AdminServiceService({required this.firestore, required this.storage});

  Future<String?> uploadImage(File image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = storage.ref().child('${AppConstants.collectionServices}/$fileName');
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      log('Error uploading image: $e', name: 'AdminServiceService');
      return null;
    }
  }


  Future<void> createService(ServiceModel service) async {
    try {
      DocumentReference docRef = firestore.collection(AppConstants.collectionServices).doc(service.id);
      await docRef.set(service.toMap());
    } catch (e) {
      log('Error creating service: $e', name: 'AdminServiceService');
    }
  }

  String generateServiceId() {
    return firestore.collection(AppConstants.collectionServices).doc().id;
  }


}