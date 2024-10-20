import 'package:car_workshop_app/features/mechanic/profile/models/mechanic_model.dart';
import 'package:flutter/material.dart';
import 'package:car_workshop_app/features/admin/service/models/service_model.dart';


class OrderModel {
  final String? orderId;
  final String? make;
  final String? model;
  final String? year;
  final String? registrationPlate;
  final String? name;
  final String? phoneNumber;
  final String? email;
  final String? bookingTitle;
  final DateTimeRange? dateRange;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final String? userId;
  final List<ServiceModel>? services;
  final MechanicModel? assignedMechanic;
  final DateTime? orderPlacedDateTime;
  final String? orderStatus;
  final double? totalAmount;

  OrderModel({
    this.orderId,
    this.make,
    this.model,
    this.year,
    this.registrationPlate,
    this.name,
    this.phoneNumber,
    this.email,
    this.bookingTitle,
    this.dateRange,
    this.startTime,
    this.endTime,
    this.userId,
    this.services,
    this.assignedMechanic,
    this.orderPlacedDateTime,
    this.orderStatus,
    this.totalAmount,
  });

  OrderModel copyWith({
    String? orderId,
    String? make,
    String? model,
    String? year,
    String? registrationPlate,
    String? name,
    String? phoneNumber,
    String? email,
    String? bookingTitle,
    DateTimeRange? dateRange,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    String? userId,
    List<ServiceModel>? services,
    MechanicModel? assignedMechanic,
    DateTime? orderPlacedDateTime,
    String? orderStatus,
    double? totalAmount,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      registrationPlate: registrationPlate ?? this.registrationPlate,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      bookingTitle: bookingTitle ?? this.bookingTitle,
      dateRange: dateRange ?? this.dateRange,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      userId: userId ?? this.userId,
      services: services ?? this.services,
      assignedMechanic: assignedMechanic ?? this.assignedMechanic,
      orderPlacedDateTime: orderPlacedDateTime ?? this.orderPlacedDateTime,
      orderStatus: orderStatus ?? this.orderStatus,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  Map<String, dynamic> toMap(BuildContext context) {
    return {
      'orderId': orderId,
      'make': make,
      'model': model,
      'year': year,
      'registrationPlate': registrationPlate,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'bookingTitle': bookingTitle,
      'dateRange': dateRange != null
          ? {
        'start': dateRange!.start.toIso8601String(),
        'end': dateRange!.end.toIso8601String(),
      }
          : null,
      'timeRange': {
        'start': startTime?.format(context),
        'end': endTime?.format(context),
      },
      'userId': userId,
      'services': services?.map((service) => service.toMap()).toList(),
      'assignedMechanic': assignedMechanic?.toMap(),
      'orderPlacedDateTime': orderPlacedDateTime?.toIso8601String(),
      'orderStatus': orderStatus,
      'totalAmount': totalAmount,
    };
  }
}
