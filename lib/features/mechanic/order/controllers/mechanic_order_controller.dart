import 'package:car_workshop_app/core/utils.dart';
import 'package:car_workshop_app/features/mechanic/order/services/mechanic_order_service.dart';
import 'package:car_workshop_app/features/user/order/models/order_model.dart';
import 'package:get/get.dart';

class MechanicOrderController extends GetxController implements GetxService {
  final MechanicOrderService mechanicOrderService;
  MechanicOrderController({required this.mechanicOrderService});

  bool isLoaded = false;

  Stream<int> getTotalOrdersAssignedToMechanic() {
    return mechanicOrderService.getTotalOrdersAssignedToMechanic();
  }

  Stream<int> getTodaysOrdersAssignedToMechanic () {
    return mechanicOrderService.getTodaysOrdersAssignedToMechanic();
  }

  Stream<List<OrderModel>> getLatestOrders() {
    return mechanicOrderService.getLatestOrders();
  }

  Stream<List<OrderModel>> fetchCompletedOrders() {
    return mechanicOrderService.fetchCompletedOrders();
  }

  Stream<List<OrderModel>> fetchRunningOrders() {
    return mechanicOrderService.fetchRunningOrders();
  }

  Stream<OrderModel?> fetchOrderById(String orderId) {
    return mechanicOrderService.fetchOrderById(orderId);
  }

  Future<void> markOrderAsCompleted(String orderId) async {
    isLoaded = true;
    update();
    try {
      mechanicOrderService.markOrderAsCompleted(orderId);
      showCustomSnacker('success', 'Order marked as completed');
    } catch (e) {
      showCustomSnacker('error', 'Error marking order as completed', isError: true);
    } finally {
      isLoaded = false;
      update();
    }
  }
}