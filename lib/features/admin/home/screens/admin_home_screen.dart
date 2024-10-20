import 'package:car_workshop_app/features/admin/dashboard/widgets/custom_card_view.dart';
import 'package:car_workshop_app/features/user/order/controllers/user_order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, Admin!',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: GetBuilder<UserOrderController>(
                  builder: (userOrderController) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        FutureBuilder(
                          future: userOrderController.getTotalOrdersCount(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CustomCardView(
                                icon: Icons.shopping_cart,
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
                                icon: Icons.shopping_cart,
                                title: 'Total Orders',
                                value: snapshot.data.toString().padLeft(2, '0'),
                              );
                            }
                          },
                        ),
                        const CustomCardView(
                          icon: Icons.person,
                          title: 'Total Mechanics',
                          value: '10',
                        ),
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
              ListView.builder(
                itemCount: 5,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: const Icon(Icons.assignment_turned_in),
                      title: Text('Order ${index + 1}'),
                      subtitle: Text('Details of order ${index + 1}.'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
