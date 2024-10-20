import 'package:car_workshop_app/features/user/order/controllers/user_order_controller.dart';
import 'package:car_workshop_app/features/user/order/models/order_model.dart';
import 'package:car_workshop_app/features/user/order/widgets/order_card_view_widget.dart';
import 'package:car_workshop_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserOrderScreen extends StatelessWidget {
  const UserOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Orders'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Running Orders'),
              Tab(text: 'Order History'),
            ],
          ),
        ),
        body: GetBuilder<UserOrderController>(
          builder: (orderController) {
            return TabBarView(
              children: [
                // Running Orders Tab
                StreamBuilder<List<OrderModel>>(
                  stream: orderController.fetchRunningOrders(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No running orders found.'));
                    }

                    final runningOrders = snapshot.data!;

                    return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: runningOrders.length,
                      itemBuilder: (context, index) {
                        final order = runningOrders[index];
                        return OrderCardViewWidget(
                          order: order,
                          onTap: () {
                            Get.toNamed(AppRoutes.getOrderDetailsRoute(order.orderId));
                          },
                        );

                      },
                    );
                  },
                ),
                // Order History Tab
                StreamBuilder<List<OrderModel>>(
                  stream: orderController.fetchCompletedOrders(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No order history found.'));
                    }

                    final completedOrders = snapshot.data!;

                    return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: completedOrders.length,
                      itemBuilder: (context, index) {
                        final order = completedOrders[index];
                        return OrderCardViewWidget(
                          onTap: () {
                            Get.toNamed(AppRoutes.getOrderDetailsRoute(order.orderId));
                          },
                          order: order,
                        );
                      },
                    );
                  },
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
