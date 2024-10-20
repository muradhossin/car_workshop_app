import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showCustomSnacker(String? title, String message, {bool isError = false}) {
  Get.snackbar(
    title ?? '',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: isError ? Colors.red : Colors.black,
    colorText: Colors.white,
    borderRadius: 10,
    margin: EdgeInsets.all(10),
    duration: Duration(seconds: 3),
    isDismissible: true,
  );
}

Color getStatusColor(String? status) {
  switch (status) {
    case 'completed':
      return Colors.green;
    case 'pending':
      return Colors.orange;
    case 'cancelled':
      return Colors.red;
    default:
      return Colors.grey;
  }
}

IconData getStatusIcon(String? status) {
  switch (status) {
    case 'completed':
      return Icons.check_circle;
    case 'pending':
      return Icons.pending;
    case 'cancelled':
      return Icons.cancel;
    default:
      return Icons.info;
  }
}

String capitalize(String? s) => s != null && s.isNotEmpty ? '${s[0].toUpperCase()}${s.substring(1)}' : '';

String formatDateTime(String? dateTimeString) {
  if (dateTimeString == null) {
    return '';
  }
  final dateTime = DateTime.parse(dateTimeString);
  final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm a');
  return formatter.format(dateTime);
}

String dateOnly(String? dateTimeString) {
  if (dateTimeString == null) {
    return 'N/A';
  }
  final dateTime = DateTime.parse(dateTimeString);
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(dateTime);
}
