import 'package:car_workshop_app/core/app_theme.dart';
import 'package:car_workshop_app/di.dart';
import 'package:car_workshop_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (GetPlatform.isAndroid || GetPlatform.isWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyATEdG5jP7FMwvyD0on7kra8HZpV0Ql3w0",
          authDomain: "car-workshop-74b81.firebaseapp.com",
          projectId: "car-workshop-74b81",
          storageBucket: "car-workshop-74b81.appspot.com",
          messagingSenderId: "810595482949",
          appId: "1:810595482949:web:b079dbee834edc0a0f922c",
          measurementId: "G-Z291TYW6T2"),
    );
  } else {
    await Firebase.initializeApp();
  }

  await Di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Workshop',
      theme: AppTheme.lightTheme,
      getPages: AppRoutes.getPages,
      initialRoute: AppRoutes.splash,
    );
  }
}
