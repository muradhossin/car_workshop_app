import 'package:car_workshop_app/base_widgets/custom_button_widget.dart';
import 'package:car_workshop_app/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_workshop_app/features/user/cart/controllers/user_cart_controller.dart';

class UserCartScreen extends StatelessWidget {
  const UserCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [
          GetBuilder<UserCartController>(
            builder: (cartController) {
              return cartController.services.isNotEmpty ? IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Clear Cart'),
                        content: const Text('Are you sure you want to clear your cart?'),
                        actions: [
                          CustomButtonWidget(
                            text: 'Cancel',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(height: 8),

                          CustomButtonWidget(
                            text: 'Clear',
                            onPressed: () {
                              cartController.clearCart();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ) : const SizedBox();
            },
          ),
        ],
      ),
      body: GetBuilder<UserCartController>(
        builder: (cartController) {
          if (cartController.services.isEmpty) {
            return const Center(
              child: Text('Your cart is empty'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: cartController.services.length,
            itemBuilder: (context, index) {
              final service = cartController.services[index];
              return Card(
                child: ListTile(
                  title: Text(service.name),
                  subtitle: Text('${service.price.toStringAsFixed(2)} ${AppConstants.currencySymbol}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      cartController.removeServiceFromCart(service.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: GetBuilder<UserCartController>(
        builder: (cartController) {
          return cartController.services.isNotEmpty ? BottomAppBar(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: ${cartController.totalPrice.toStringAsFixed(2)} ${AppConstants.currencySymbol}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                    },
                    child: const Text('Checkout', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ) : const SizedBox();
        },
      ),
    );
  }
}