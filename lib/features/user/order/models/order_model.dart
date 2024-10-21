import 'package:car_workshop_app/features/auth/models/user_model.dart';
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
  final UserModel? assignedMechanic;
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
    UserModel? assignedMechanic,
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


  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'],
      make: map['make'],
      model: map['model'],
      year: map['year'],
      registrationPlate: map['registrationPlate'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      bookingTitle: map['bookingTitle'],
      dateRange: map['dateRange'] != null
          ? DateTimeRange(
        start: DateTime.parse(map['dateRange']['start']),
        end: DateTime.parse(map['dateRange']['end']),
      )
          : null,
      startTime: map['timeRange'] != null && map['timeRange']['start'] != null
          ? TimeOfDay(
        hour: int.parse(map['timeRange']['start'].split(':')[0]),
        minute: int.parse(map['timeRange']['start'].split(':')[1].split(' ')[0]),
      )
          : null,
      endTime: map['timeRange'] != null && map['timeRange']['end'] != null
          ? TimeOfDay(
        hour: int.parse(map['timeRange']['end'].split(':')[0]),
        minute: int.parse(map['timeRange']['end'].split(':')[1].split(' ')[0]),
      )
          : null,
      userId: map['userId'],
      services: map['services'] != null
          ? List<ServiceModel>.from(
          map['services'].map((service) => ServiceModel.fromMap(service)))
          : null,
      assignedMechanic: map['assignedMechanic'] != null
          ? UserModel.fromMap(map['assignedMechanic'])
          : null,
      orderPlacedDateTime: map['orderPlacedDateTime'] != null
          ? DateTime.parse(map['orderPlacedDateTime'])
          : null,
      orderStatus: map['orderStatus'],
      totalAmount: map['totalAmount'],
    );
  }
}

