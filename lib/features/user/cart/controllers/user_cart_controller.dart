import 'package:car_workshop_app/core/utils.dart';
import 'package:car_workshop_app/features/admin/service/models/service_model.dart';
import 'package:car_workshop_app/features/user/cart/models/cart_model.dart';
import 'package:car_workshop_app/features/user/cart/services/user_cart_service.dart';
import 'package:get/get.dart';

class UserCartController extends GetxController implements GetxService {
  final UserCartService userCartService;
  UserCartController({required this.userCartService});

  List<ServiceModel> services = [];

  void addToCart(ServiceModel service) {
    if (services.any((existingService) => existingService.id == service.id)) {
      showCustomSnacker('Info', 'Service is already in the cart.');
      return;
    }
    services.add(service);
    saveCart();
    update();
  }

  Future<void> saveCart() async {
    try {
      final cart = CartModel(userId: userCartService.auth.currentUser!.uid, services: services);
      await userCartService.saveCart(cart);
      showCustomSnacker('Success', 'Cart saved successfully.');
      loadCart();
    } catch (e) {
      showCustomSnacker('Error', 'Failed to save cart: $e', isError: true);
    }
  }

  Future<void> loadCart() async {
    try {
      final cart = await userCartService.getCart();
      if (cart != null) {
        services = cart.services;
        update();
      }
    } catch (e) {
      showCustomSnacker('Error', 'Failed to load cart: $e', isError: true);
    }
  }

  Future<void> clearCart({bool showSnack = true}) async {
    try {
      await userCartService.clearCart();
      services.clear();
      update();
      if(showSnack) showCustomSnacker('Success', 'Cart cleared successfully.');
    } catch (e) {
      if(showSnack) showCustomSnacker('Error', 'Failed to clear cart: $e', isError: true);
    }
  }

  Future<void> removeServiceFromCart(String serviceId) async {
    try {
      await userCartService.removeServiceFromCart(serviceId);
      services.removeWhere((service) => service.id == serviceId);
      update();
      showCustomSnacker('Success', 'Service removed from cart successfully.');
    } catch (e) {
      showCustomSnacker('Error', 'Failed to remove service from cart: $e', isError: true);
    }
  }

  double get totalPrice => services.fold(0, (sum, service) => sum + service.price);
  int get cartCount => services.length;
}