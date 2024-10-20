import 'package:car_workshop_app/constants/app_constants.dart';
import 'package:car_workshop_app/core/utils.dart';
import 'package:car_workshop_app/features/user/cart/controllers/user_cart_controller.dart';
import 'package:car_workshop_app/features/user/checkout/services/user_checkout_service.dart';
import 'package:car_workshop_app/features/user/order/models/order_model.dart';
import 'package:car_workshop_app/routes/app_routes.dart';
import 'package:get/get.dart';

class UserCheckoutController extends GetxController implements GetxService{
  final UserCheckoutService userCheckoutService;
  UserCheckoutController({required this.userCheckoutService});

  bool isLoader = false;

  void placeOrder(OrderModel order) async {
    isLoader = true;
    update();
    try {
      await userCheckoutService.placeOrder(order);
      showCustomSnacker('Success', 'Your order has been placed successfully');
      Get.offAllNamed(AppRoutes.getUserDashboardRoute());
      Get.find<UserCartController>().clearCart(showSnack: false);
    } catch (e) {
      showCustomSnacker('Error', e.toString(), isError: true);
    } finally {
      isLoader = false;
      update();
    }
  }
}