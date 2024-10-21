import 'package:car_workshop_app/core/auth_middleware.dart';
import 'package:car_workshop_app/features/admin/dashboard/screens/admin_dashboard.dart';
import 'package:car_workshop_app/features/admin/order/screens/admin_order_details_screen.dart';
import 'package:car_workshop_app/features/auth/screens/login_screen.dart';
import 'package:car_workshop_app/features/auth/screens/registration_screen.dart';
import 'package:car_workshop_app/features/mechanic/dashboard/screens/mechanic_dashboard.dart';
import 'package:car_workshop_app/features/splash/screens/splash_screen.dart';
import 'package:car_workshop_app/features/user/checkout/screens/user_checkout_screen.dart';
import 'package:car_workshop_app/features/user/dashboard/screens/user_dashboard.dart';
import 'package:car_workshop_app/features/user/order/screens/user_order_details_screen.dart';
import 'package:car_workshop_app/main.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String home = '/';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String userDashboard = '/user-dashboard';
  static const String adminDashboard = '/admin-dashboard';
  static const String mechanicDashboard = '/mechanic-dashboard';
  static const String checkout = '/checkout';
  static const String orderDetails = '/order-details';
  static const String adminOrderDetails = '/admin-order-details';

  static getHomeRoute() => home;
  static getSplashRoute() => splash;
  static getLoginRoute() => login;
  static getRegisterRoute() => register;
  static getUserDashboardRoute() => userDashboard;
  static getAdminDashboardRoute() => adminDashboard;
  static getMechanicDashboardRoute() => mechanicDashboard;
  static getCheckoutRoute() => checkout;
  static getOrderDetailsRoute(String? orderId) => '$orderDetails?orderId=$orderId';
  static getAdminOrderDetailsRoute(String? orderId) => '$adminOrderDetails?orderId=$orderId';


  static List<GetPage<dynamic>> getPages = [
    

    GetPage(
      name: splash,
      page: () =>  SplashScreen(),
    ),

    GetPage(
      name: login,
      page: () =>  LoginScreen(),
    ),

    GetPage(
      name: register,
      page: () =>  RegistrationScreen(),
    ),

    GetPage(
      name: userDashboard,
      page: () =>  UserDashboard(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: adminDashboard,
      page: () =>  AdminDashboard(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: mechanicDashboard,
      page: () =>  MechanicDashboard(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: checkout,
      page: () =>  UserCheckoutScreen(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: orderDetails,
      page: () =>  UserOrderDetailsScreen(
        orderId: Get.parameters['orderId'],
      ),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: adminOrderDetails,
      page: () =>  AdminOrderDetailsScreen(
        orderId: Get.parameters['orderId'],
      ),
      middlewares: [AuthMiddleware()],
    ),

    
    
  ];

}

