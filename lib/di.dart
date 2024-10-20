import 'package:car_workshop_app/features/admin/service/controllers/admin_service_controller.dart';
import 'package:car_workshop_app/features/admin/service/services/admin_service_service.dart';
import 'package:car_workshop_app/features/auth/controllers/auth_controller.dart';
import 'package:car_workshop_app/features/auth/services/auth_service.dart';
import 'package:car_workshop_app/features/user/cart/controllers/user_cart_controller.dart';
import 'package:car_workshop_app/features/user/cart/services/user_cart_service.dart';
import 'package:car_workshop_app/features/user/checkout/controllers/user_checkout_controller.dart';
import 'package:car_workshop_app/features/user/checkout/services/user_checkout_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


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

    // Initialize Firebase Storage
    final storage = FirebaseStorage.instance;
    Get.lazyPut<FirebaseStorage>(() => storage);

    // Services
    Get.lazyPut<AuthService>(() => AuthService(firestore: firestore, auth: auth));
    Get.lazyPut<AdminServiceService>(() => AdminServiceService(firestore: firestore, storage: storage));
    Get.lazyPut<UserCartService>(() => UserCartService(firestore: firestore, auth: auth));
    Get.lazyPut<UserCheckoutService>(() => UserCheckoutService(firestore: firestore, auth: auth));
   

    // Controllers
    Get.lazyPut<AuthController>(() => AuthController(authService: Get.find<AuthService>()));  
    Get.lazyPut<AdminServiceController>(() => AdminServiceController(adminServiceService: Get.find<AdminServiceService>()));
    Get.lazyPut<UserCartController>(() => UserCartController(userCartService: Get.find<UserCartService>()));
    Get.lazyPut<UserCheckoutController>(() => UserCheckoutController(userCheckoutService: Get.find<UserCheckoutService>()));

  }
}