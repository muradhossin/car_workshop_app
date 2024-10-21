import 'package:car_workshop_app/base_widgets/custom_button_widget.dart';
import 'package:car_workshop_app/constants/app_constants.dart';
import 'package:car_workshop_app/core/utils.dart';
import 'package:car_workshop_app/features/mechanic/order/controllers/mechanic_order_controller.dart';
import 'package:car_workshop_app/features/user/order/models/order_status.dart';
import 'package:car_workshop_app/features/user/order/widgets/order_details_row_widget.dart';
import 'package:car_workshop_app/features/user/order/widgets/order_info_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_workshop_app/features/user/order/controllers/user_order_controller.dart';
import 'package:car_workshop_app/features/user/order/models/order_model.dart';

class MechanicOrderDetailsScreen extends StatelessWidget {
  final String? orderId;

  const MechanicOrderDetailsScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details #$orderId'),
      ),
      body: GetBuilder<MechanicOrderController>(
        builder: (orderController) {
          return StreamBuilder<OrderModel?>(
            stream: orderController.fetchOrderById(orderId!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error fetching order details'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('Order not found'));
              } else {
                final order = snapshot.data!;
                return Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OrderInfoCardWidget(
                                title: 'Order Info',
                                children: [
                                  OrderDetailRowWidget(label: 'Order ID', value: '#${order.orderId}'),
                                  OrderDetailRowWidget(label: 'Status', value: capitalize(order.orderStatus ?? 'N/A')),
                                  OrderDetailRowWidget(label: 'Created', value: formatDateTime(order.orderPlacedDateTime.toString())),
                                ],
                              ),
                              OrderInfoCardWidget(
                                title: 'Customer Information',
                                children: [
                                  OrderDetailRowWidget(label: 'Name', value: order.name ?? 'N/A'),
                                  OrderDetailRowWidget(label: 'Phone', value: order.phoneNumber ?? 'N/A'),
                                  OrderDetailRowWidget(label: 'Email', value: order.email ?? 'N/A'),
                                ],
                              ),
                              OrderInfoCardWidget(
                                title: 'Vehicle Information',
                                children: [
                                  OrderDetailRowWidget(label: 'Make', value: order.make ?? 'N/A'),
                                  OrderDetailRowWidget(label: 'Model', value: order.model ?? 'N/A'),
                                  OrderDetailRowWidget(label: 'Year', value: order.year ?? 'N/A'),
                                  OrderDetailRowWidget(label: 'Registration Plate', value: order.registrationPlate ?? 'N/A'),
                                ],
                              ),
                              OrderInfoCardWidget(
                                title: 'Booking Details',
                                children: [
                                  OrderDetailRowWidget(label: 'Title', value: order.bookingTitle ?? 'N/A'),
                                  OrderDetailRowWidget(label: 'Start Date', value: dateOnly(order.dateRange?.start.toLocal().toString())),
                                  OrderDetailRowWidget(label: 'End Date', value:  dateOnly(order.dateRange?.end.toLocal().toString())),
                                  OrderDetailRowWidget(label: 'Start Time', value: order.startTime?.format(context) ?? 'N/A'),
                                  OrderDetailRowWidget(label: 'End Time', value: order.endTime?.format(context) ?? 'N/A'),
                                ],
                              ),
                              OrderInfoCardWidget(
                                title: 'Services',
                                children: [
                                  if (order.services != null && order.services!.isNotEmpty)
                                    Column(
                                      children: order.services!.map((service) {
                                        return OrderDetailRowWidget(
                                          label: service.name ?? 'N/A',
                                          value: '${service.price?.toStringAsFixed(2) ?? '0.00'} ${AppConstants.currencySymbol}',
                                        );
                                      }).toList(),
                                    )
                                  else
                                    const Text('No services provided'),
                                ],
                              ),
                              OrderInfoCardWidget(
                                title: 'Total Amount',
                                children: [
                                  OrderDetailRowWidget(label: 'Amount', value: '${order.totalAmount?.toStringAsFixed(2) ?? '0.00'} ${AppConstants.currencySymbol}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    order.orderStatus == OrderStatus.cancelled.name || order.orderStatus == OrderStatus.completed.name ? const SizedBox.shrink() : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      child: CustomButtonWidget(
                        isLoading: orderController.isLoaded,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Mark Order as Completed'),
                                content: const Text('Are you sure you want to mark this order as completed?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                      orderController.markOrderAsCompleted(order.orderId!);

                                    },
                                    child: const Text('Mark as Completed'),
                                  ),
                                ],
                              );
                            },
                          );

                        },
                        text: 'Mark as Completed',
                      ),
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }
}




