import 'package:car_workshop_app/features/admin/order/controllers/admin_order_controller.dart';
import 'package:car_workshop_app/features/mechanic/order/controllers/mechanic_order_controller.dart';
import 'package:car_workshop_app/features/user/order/models/order_model.dart';
import 'package:car_workshop_app/features/user/order/widgets/order_card_view_widget.dart';
import 'package:car_workshop_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';

class MechanicBookingScreen extends StatefulWidget {
  @override
  _MechanicBookingScreenState createState() => _MechanicBookingScreenState();
}

class _MechanicBookingScreenState extends State<MechanicBookingScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late Map<DateTime, List<OrderModel>> _ordersForDays;
  late final MechanicOrderController _orderController;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _orderController = Get.find<MechanicOrderController>();
    _ordersForDays = {};
    _fetchAllOrders();
  }

  Future<void> _fetchAllOrders() async {
    _orderController.getLatestOrders().listen((orders) {
      Map<DateTime, List<OrderModel>> ordersByDay = {};
      for (var order in orders) {
        final orderDate = DateTime(order.orderPlacedDateTime!.year, order.orderPlacedDateTime!.month, order.orderPlacedDateTime!.day);
        if (ordersByDay[orderDate] == null) {
          ordersByDay[orderDate] = [];
        }
        ordersByDay[orderDate]!.add(order);
      }

      setState(() {
        _ordersForDays = ordersByDay;
      });
    });
  }

  List<OrderModel> _getOrdersForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return _ordersForDays[normalizedDay] ?? [];
  }

  int _getOrderCountForDay(DateTime day) {
    return _getOrdersForDay(day).length;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Bookings'),
      ),
      body: Column(
        children: [
          TableCalendar<OrderModel>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: _onDaySelected,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              todayDecoration: const BoxDecoration(
                color: Colors.orangeAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
            ),
            eventLoader: _getOrdersForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                int orderCount = _getOrderCountForDay(date);
                if (orderCount > 0) {
                  return Positioned(
                    right: 1,
                    bottom: 1,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$orderCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: _getOrdersForDay(_selectedDay!).isEmpty ? const Center(
              child: Text('No orders found for the selected day.'),
            ) : ListView.builder(
              itemCount: _getOrdersForDay(_selectedDay!).length,
              itemBuilder: (context, index) {
                final order = _getOrdersForDay(_selectedDay!)[index];
                return OrderCardViewWidget(
                  order: order,
                  onTap: () {
                    Get.toNamed(AppRoutes.getAdminOrderDetailsRoute(order.orderId));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
