import 'dart:developer';

import 'package:car_workshop_app/base_widgets/custom_button_widget.dart';
import 'package:car_workshop_app/constants/app_constants.dart';
import 'package:car_workshop_app/core/utils.dart';
import 'package:car_workshop_app/features/auth/controllers/auth_controller.dart';
import 'package:car_workshop_app/features/auth/models/user_model.dart';
import 'package:car_workshop_app/features/user/checkout/controllers/user_checkout_controller.dart';
import 'package:car_workshop_app/features/user/order/models/order_model.dart';
import 'package:car_workshop_app/features/user/order/models/order_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_workshop_app/features/user/cart/controllers/user_cart_controller.dart';

class UserCheckoutScreen extends StatefulWidget {
  const UserCheckoutScreen({super.key});

  @override
  _UserCheckoutScreenState createState() => _UserCheckoutScreenState();
}

class _UserCheckoutScreenState extends State<UserCheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTimeRange? _selectedDateRange;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  UserModel? _userModel;

  TextEditingController _makeController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _yearController = TextEditingController();
  TextEditingController _registrationPlateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _bookingTitleController = TextEditingController();


  Future<void> _selectTimeRange(BuildContext context) async {
    final TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedStartTime != null) {
      final TimeOfDay? pickedEndTime = await showTimePicker(
        context: context,
        initialTime: pickedStartTime,
      );
      if (pickedEndTime != null) {
        setState(() {
          _startTime = pickedStartTime;
          _endTime = pickedEndTime;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserInfo();
  }

  void _getUserInfo() async {
    _userModel = await Get.find<AuthController>().getCurrentUser();
    if(_userModel != null){
      log('User id: ${_userModel?.id}');
      _nameController.text = _userModel?.name ?? '';
      _emailController.text = _userModel?.email ?? '';
      _phoneNumberController.text = _userModel?.phone ?? '';
    }
  }

  void _placeOrder() async {
    final cartController = Get.find<UserCartController>();
    final checkoutController = Get.find<UserCheckoutController>();

    if (_formKey.currentState!.validate() && _selectedDateRange != null && _startTime != null && _endTime != null) {
      final order = OrderModel(
        orderId: null,
        make: _makeController.text,
        model: _modelController.text,
        year: _yearController.text,
        registrationPlate: _registrationPlateController.text,
        name: _nameController.text,
        phoneNumber: _phoneNumberController.text,
        email: _emailController.text,
        bookingTitle: _bookingTitleController.text,
        dateRange: _selectedDateRange,
        startTime: _startTime,
        endTime: _endTime,
        userId: _userModel?.id,
        services: cartController.services,
        assignedMechanic: null,
        orderPlacedDateTime: DateTime.now(),
        orderStatus: OrderStatus.pending.name,
        totalAmount: cartController.totalPrice,
      );

      checkoutController.placeOrder(order);

    } else {
      showCustomSnacker(
        'Error',
        'Please select date and time range',
        isError: true,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: GetBuilder<UserCartController>(
        builder: (cartController) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [

                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Order Summary',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: cartController.services.length,
                                  itemBuilder: (context, index) {
                                    final service = cartController.services[index];
                                    return ListTile(
                                      title: Text(service.name),
                                      subtitle: Text('${service.price.toStringAsFixed(2)} ${AppConstants.currencySymbol}'),
                                    );
                                  },
                                ),
                                const Divider(),
                                Text(
                                  'Total: ${cartController.totalPrice.toStringAsFixed(2)} ${AppConstants.currencySymbol}',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Car Details',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _makeController,
                                  decoration: const InputDecoration(labelText: 'Make'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter car make';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: _modelController,
                                  decoration: const InputDecoration(labelText: 'Model'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter car model';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: _yearController,
                                  decoration: const InputDecoration(labelText: 'Year'),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter car year';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: _registrationPlateController,
                                  decoration: const InputDecoration(labelText: 'Registration Plate'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter registration plate';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Customer Details',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(labelText: 'Name'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: _phoneNumberController,
                                  decoration: const InputDecoration(labelText: 'Phone Number'),
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your phone number';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(labelText: 'Email'),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Booking Details',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _bookingTitleController,
                                  decoration: const InputDecoration(labelText: 'Booking Title'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter booking title';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                ListTile(
                                  title: const Text('Select Date Range'),
                                  subtitle: Text(
                                    _selectedDateRange == null
                                        ? 'No date range selected'
                                        : '${_selectedDateRange!.start.toLocal().toString().split(' ')[0]} - ${_selectedDateRange!.end.toLocal().toString().split(' ')[0]}',
                                  ),
                                  trailing: const Icon(Icons.calendar_today),
                                  onTap: () async {
                                    DateTimeRange? picked = await showDateRangePicker(
                                      context: context,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2101),
                                    );
                                    if (picked != null) {
                                      setState(() {
                                        _selectedDateRange = picked;
                                      });
                                    }
                                  },
                                ),
                                const SizedBox(height: 16),
                                ListTile(
                                  title: const Text('Select Time Range'),
                                  subtitle: Text(
                                    _startTime == null || _endTime == null
                                        ? 'No time range selected'
                                        : '${_startTime!.format(context)} - ${_endTime!.format(context)}',
                                  ),
                                  trailing: const Icon(Icons.access_time),
                                  onTap: () => _selectTimeRange(context),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                  ),
                  child: GetBuilder<UserCheckoutController>(
                    builder: (checkoutController) {
                      return CustomButtonWidget(
                        isLoading: checkoutController.isLoader,
                        text: 'Place Order',
                        onPressed: _placeOrder,
                      );
                    }
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _makeController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _registrationPlateController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _bookingTitleController.dispose();
    super.dispose();
  }
}