import 'package:car_workshop_app/constants/app_constants.dart';
import 'package:car_workshop_app/core/utils.dart';
import 'package:car_workshop_app/features/user/order/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderCardViewWidget extends StatelessWidget {
  final OrderModel order;
  const OrderCardViewWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Order ID: #${order.orderId}', style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total: ${order.totalAmount?.toStringAsFixed(2) ?? '0.00'} ${AppConstants.currencySymbol}'),
            Text('Order Created: ${formatDateTime(order.orderPlacedDateTime.toString())}'),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              capitalize(order.orderStatus ?? 'N/A'),
              style: TextStyle(fontWeight: FontWeight.bold, color: getStatusColor(order.orderStatus)),
            ),
            const SizedBox(height: 4),
            Icon(
              getStatusIcon(order.orderStatus),
              color: getStatusColor(order.orderStatus),
            ),
          ],
        ),
      ),
    );
  }
}
