import 'package:car_workshop_app/constants/app_constants.dart';
import 'package:car_workshop_app/core/utils.dart';
import 'package:car_workshop_app/features/user/order/widgets/order_details_row_widget.dart';
import 'package:car_workshop_app/features/user/order/widgets/order_info_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_workshop_app/features/user/order/controllers/user_order_controller.dart';
import 'package:car_workshop_app/features/user/order/models/order_model.dart';

class UserOrderDetailsScreen extends StatelessWidget {
  final String? orderId;

  const UserOrderDetailsScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details #$orderId'),
      ),
      body: GetBuilder<UserOrderController>(
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
                return Padding(
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
                          title: 'Assigned Mechanic',
                          children: [
                            if (order.assignedMechanic != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  OrderDetailRowWidget(label: 'Name', value: order.assignedMechanic?.name ?? 'N/A'),
                                  OrderDetailRowWidget(label: 'Phone', value: order.assignedMechanic?.phoneNumber ?? 'N/A'),
                                  OrderDetailRowWidget(label: 'Email', value: order.assignedMechanic?.email ?? 'N/A'),
                                ],
                              )
                            else
                              const Text('No mechanic assigned'),
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
                );
              }
            },
          );
        },
      ),
    );
  }
}




