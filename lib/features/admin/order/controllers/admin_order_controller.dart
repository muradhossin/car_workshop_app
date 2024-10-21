import 'package:car_workshop_app/core/utils.dart';
import 'package:car_workshop_app/features/admin/order/services/admin_order_service.dart';
import 'package:car_workshop_app/features/user/order/models/order_model.dart';
import 'package:get/get.dart';

class AdminOrderController extends GetxController implements GetxService {
 final AdminOrderService adminOrderService;
  AdminOrderController({required this.adminOrderService});

  bool isLoaded = false;
  String? selectedStatus;

  void setSelectedOrderStatus (String? orderStatus, {bool isUpdate = true}) {
    selectedStatus = orderStatus;
    if(isUpdate) update();
  }


  Stream<List<OrderModel>> streamLatestOrders() {
   return adminOrderService.streamLatestOrders();
  }

  Stream<OrderModel?> fetchOrderById(String orderId) {
    return adminOrderService.fetchOrderById(orderId);
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    isLoaded = true;
    update();
    try {
      await adminOrderService.updateOrderStatus(orderId, newStatus);
      showCustomSnacker('success', 'Order status updated successfully');
    } catch (e) {
      showCustomSnacker('error', 'Error updating order status. Please try again.');
      throw Exception('Error updating order status. Please try again.');
    }finally{
      isLoaded = false;
      update();
    }
  }
}