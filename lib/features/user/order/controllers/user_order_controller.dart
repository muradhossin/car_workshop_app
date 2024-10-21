import 'package:car_workshop_app/features/user/order/models/order_model.dart';
import 'package:car_workshop_app/features/user/order/services/user_order_service.dart';
import 'package:get/get.dart';

class UserOrderController extends GetxController implements GetxService {
  final UserOrderService userOrderService;
  UserOrderController({required this.userOrderService});

  Stream<List<OrderModel>> fetchRunningOrders() {
    return userOrderService.fetchRunningOrders();
  }

  Stream<List<OrderModel>> fetchCompletedOrders() {
    return userOrderService.fetchCompletedOrders();
  }

  Stream<OrderModel?> fetchOrderById(String orderId) {
    return userOrderService.fetchOrderById(orderId);
  }

  Stream<int> getTotalOrdersCount() {
    return userOrderService.getTotalOrdersCount();
  }


}