import 'package:car_workshop_app/features/login/controllers/login_controller.dart';
import 'package:car_workshop_app/features/login/services/login_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Di {
  static Future<void> init() async {

    // initialize Firestore instance
    final firestore = FirebaseFirestore.instance;
    Get.lazyPut<FirebaseFirestore>(() => firestore);

    // Initialize SharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut<SharedPreferences>(() => sharedPreferences);

    // Services
    Get.lazyPut<LoginService>(() => LoginService(firestore: firestore));

    // Controllers
    Get.lazyPut<LoginController>(() => LoginController(loginService: Get.find<LoginService>()));  

  }
}