import 'package:car_workshop_app/features/auth/controllers/auth_controller.dart';
import 'package:car_workshop_app/features/auth/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Di {
  static Future<void> init() async {

    // initialize Firestore instance
    final firestore = FirebaseFirestore.instance;
    Get.lazyPut<FirebaseFirestore>(() => firestore);

    // Initialize SharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut<SharedPreferences>(() => sharedPreferences);

    // Initialize Firebase Auth
    final auth = FirebaseAuth.instance;
    Get.lazyPut<FirebaseAuth>(() => auth);

    // Services
    Get.lazyPut<AuthService>(() => AuthService(firestore: firestore, auth: auth));

    // Controllers
    Get.lazyPut<AuthController>(() => AuthController(authService: Get.find<AuthService>()));  

  }
}