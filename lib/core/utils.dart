import 'package:get/get.dart';
import 'package:flutter/material.dart';

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