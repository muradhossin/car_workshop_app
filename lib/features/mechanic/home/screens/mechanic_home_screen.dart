import 'package:car_workshop_app/constants/app_constants.dart';
import 'package:car_workshop_app/features/admin/dashboard/widgets/custom_card_view.dart';
import 'package:car_workshop_app/features/admin/mechanics/controllers/admin_mechanic_controller.dart';
import 'package:car_workshop_app/features/admin/order/controllers/admin_order_controller.dart';
import 'package:car_workshop_app/features/mechanic/order/controllers/mechanic_order_controller.dart';
import 'package:car_workshop_app/features/user/order/controllers/user_order_controller.dart';
import 'package:car_workshop_app/features/user/order/models/order_model.dart';
import 'package:car_workshop_app/features/user/order/widgets/order_card_view_widget.dart';
import 'package:car_workshop_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MechanicHomeScreen extends StatelessWidget {
  const MechanicHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mechanic Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, Mechanic!',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: GetBuilder<MechanicOrderController>(
                    builder: (mechanicOrderController) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          StreamBuilder(
                            stream: mechanicOrderController.getTodaysOrdersAssignedToMechanic(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CustomCardView(
                                  icon: Icons.shopping_cart_outlined,
                                  title: 'Todays Orders',
                                  value: '...',
                                );
                              } else if (snapshot.hasError) {
                                return const CustomCardView(
                                  icon: Icons.error,
                                  title: 'Todays Orders',
                                  value: 'Error',
                                );
                              } else {
                                return CustomCardView(
                                  icon: Icons.shopping_cart_outlined,
                                  title: 'Todays Orders',
                                  value: snapshot.data.toString().padLeft(2, '0'),
                                );
                              }
                            },
                          ),
                          StreamBuilder(
                            stream: mechanicOrderController.getTotalOrdersAssignedToMechanic(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CustomCardView(
                                  icon: Icons.shopping_cart_sharp,
                                  title: 'Total Orders',
                                  value: '...',
                                );
                              } else if (snapshot.hasError) {
                                return const CustomCardView(
                                  icon: Icons.error,
                                  title: 'Total Orders',
                                  value: 'Error',
                                );
                              } else {
                                return CustomCardView(
                                  icon: Icons.shopping_cart_sharp,
                                  title: 'Total Orders',
                                  value: snapshot.data.toString().padLeft(2, '0'),
                                );
                              }
                            },
                          )
                        ],
                      );
                    }
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Latest Orders',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              GetBuilder<MechanicOrderController>(
                  builder: (orderController) {
                    return StreamBuilder<List<OrderModel>>(
                      stream: orderController.getLatestOrders(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No orders found.'));
                        }

                        final completedOrders = snapshot.data!;

                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: completedOrders.length,
                          itemBuilder: (context, index) {
                            final order = completedOrders[index];
                            return OrderCardViewWidget(
                              order: order,
                              onTap: () {
                                Get.toNamed(AppRoutes.getMechanicOrderDetailsRoute(order.orderId));
                              },
                            );
                          },
                        );
                      },
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
