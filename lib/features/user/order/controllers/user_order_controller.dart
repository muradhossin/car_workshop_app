import 'package:car_workshop_app/features/user/order/models/order_model.dart';
import 'package:car_workshop_app/features/user/order/services/user_order_service.dart';
import 'package:get/get.dart';

class UserOrderController extends GetxController implements GetxService {
  final UserOrderService userOrderService;
  UserOrderController({required this.userOrderService});

  Future<List<OrderModel>> fetchRunningOrders() async {
    return await userOrderService.fetchRunningOrders();
  }

  Future<List<OrderModel>> fetchCompletedOrders() async {
    return await userOrderService.fetchCompletedOrders();
  }

  Future<OrderModel?> fetchOrderById(String orderId) async {
    return await userOrderService.fetchOrderById(orderId);
  }

  Future<int> getTotalOrdersCount() async {
    return await userOrderService.getTotalOrdersCount();
  }
}