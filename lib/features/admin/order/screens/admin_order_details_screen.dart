import 'package:car_workshop_app/base_widgets/custom_button_widget.dart';
import 'package:car_workshop_app/constants/app_constants.dart';
import 'package:car_workshop_app/core/utils.dart';
import 'package:car_workshop_app/features/admin/order/controllers/admin_order_controller.dart';
import 'package:car_workshop_app/features/mechanic/profile/controllers/mechanic_profile_controller.dart';
import 'package:car_workshop_app/features/mechanic/profile/models/mechanic_model.dart';
import 'package:car_workshop_app/features/user/order/models/order_status.dart';
import 'package:car_workshop_app/features/user/order/widgets/order_details_row_widget.dart';
import 'package:car_workshop_app/features/user/order/widgets/order_info_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_workshop_app/features/user/order/models/order_model.dart';

class AdminOrderDetailsScreen extends StatefulWidget {
  final String? orderId;

  const AdminOrderDetailsScreen({super.key, required this.orderId});

  @override
  AdminOrderDetailsScreenState createState() => AdminOrderDetailsScreenState();
}

class AdminOrderDetailsScreenState extends State<AdminOrderDetailsScreen> {
  late AdminOrderController _orderController;
  late MechanicProfileController _mechanicController;

  MechanicModel? _selectedMechanic;
  bool isFirstTime = false;

  @override
  void initState() {
    super.initState();
    _orderController = Get.find<AdminOrderController>();
    _mechanicController = Get.find<MechanicProfileController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details #${widget.orderId}'),
      ),
      body: GetBuilder<AdminOrderController>(
        builder: (orderController) {
          return StreamBuilder<OrderModel?>(
            stream: orderController.fetchOrderById(widget.orderId!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error fetching order details'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('Order not found'));
              } else {
                final order = snapshot.data!;
                if(!isFirstTime) {
                  orderController.setSelectedOrderStatus(order.orderStatus, isUpdate: false);
                  isFirstTime = true;
                }
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Order Information
                            OrderInfoCardWidget(
                              title: 'Order Info',
                              children: [
                                OrderDetailRowWidget(label: 'Order ID', value: '#${order.orderId}'),
                                OrderDetailRowWidget(label: 'Order Status', value: capitalize(order.orderStatus)),
                                OrderDetailRowWidget(label: 'Created', value: formatDateTime(order.orderPlacedDateTime.toString())),
                              ],
                            ),

                            // Customer Information
                            OrderInfoCardWidget(
                              title: 'Customer Information',
                              children: [
                                OrderDetailRowWidget(label: 'Name', value: order.name ?? 'N/A'),
                                OrderDetailRowWidget(label: 'Phone', value: order.phoneNumber ?? 'N/A'),
                                OrderDetailRowWidget(label: 'Email', value: order.email ?? 'N/A'),
                              ],
                            ),

                            // Vehicle Information
                            OrderInfoCardWidget(
                              title: 'Vehicle Information',
                              children: [
                                OrderDetailRowWidget(label: 'Make', value: order.make ?? 'N/A'),
                                OrderDetailRowWidget(label: 'Model', value: order.model ?? 'N/A'),
                                OrderDetailRowWidget(label: 'Year', value: order.year ?? 'N/A'),
                                OrderDetailRowWidget(label: 'Registration Plate', value: order.registrationPlate ?? 'N/A'),
                              ],
                            ),

                            // Booking Details
                            OrderInfoCardWidget(
                              title: 'Booking Details',
                              children: [
                                OrderDetailRowWidget(label: 'Title', value: order.bookingTitle ?? 'N/A'),
                                OrderDetailRowWidget(label: 'Start Date', value: dateOnly(order.dateRange?.start.toLocal().toString())),
                                OrderDetailRowWidget(label: 'End Date', value: dateOnly(order.dateRange?.end.toLocal().toString())),
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

                            // Total Amount
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

                    (order.orderStatus == OrderStatus.cancelled.name || order.orderStatus == OrderStatus.completed.name) ? const SizedBox() : Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, -1),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DropdownButton<String>(
                            value: orderController.selectedStatus,
                            isDense: true,
                            isExpanded: false,
                            padding: EdgeInsets.zero,
                            hint: const Text('Change Order Status'),
                            items: [OrderStatus.pending.name, OrderStatus.processing.name, OrderStatus.completed.name, OrderStatus.cancelled.name]
                                .map((status) => DropdownMenuItem<String>(

                              value: status,
                              child: Text(capitalize(status)),
                            ))
                                .toList(),
                            onChanged: (newValue) {
                              orderController.setSelectedOrderStatus(newValue);
                            },
                          ),
                          const SizedBox(width: 16),

                          Expanded(
                            child: CustomButtonWidget(
                              isLoading: orderController.isLoaded,
                              text: 'Update Status',
                              onPressed: () {
                                if(orderController.selectedStatus != order.orderStatus) {
                                  _orderController.updateOrderStatus(order.orderId!, orderController.selectedStatus!);
                                } else {
                                  showCustomSnacker('No changes', 'Please select a different status to update', isError: true);
                                }
                              },
                            ),
                          ),
                        ],
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
