import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AdminBookingScreen extends StatefulWidget {
  @override
  _AdminBookingScreenState createState() => _AdminBookingScreenState();
}

class _AdminBookingScreenState extends State<AdminBookingScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late List<Booking> _selectedBookings;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedBookings = _getBookingsForDay(_selectedDay!);
  }

  List<Booking> _getBookingsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  int _getBookingCountForDay(DateTime day) {
    return _getBookingsForDay(day).length;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedBookings = _getBookingsForDay(selectedDay);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Bookings'),
      ),
      body: Column(
        children: [
          TableCalendar<Booking>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            eventLoader: _getBookingsForDay,
            onDaySelected: _onDaySelected,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              todayDecoration: BoxDecoration(
                color: Colors.orangeAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
            ),
            startingDayOfWeek: StartingDayOfWeek.monday,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
            headerStyle:
                HeaderStyle(titleCentered: true, formatButtonVisible: false),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    right: 1,
                    bottom: 1,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${_getBookingCountForDay(date)}',
                        style: TextStyle().copyWith(
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
              child: ListView.builder(
            itemCount: _selectedBookings.length,
            itemBuilder: (context, index) {
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                child: ListTile(
                  title: Text(_selectedBookings[index].title),
                  subtitle: Text(
                    '${_selectedBookings[index].carMake} ${_selectedBookings[index].carModel} '
                    '(${_selectedBookings[index].startTime.hour}:00 - ${_selectedBookings[index].endTime.hour}:00)',
                  ),
                  onTap: () {
                    // Handle tap for booking details if needed
                  },
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}

// Sample Event model for your booking
class Booking {
  final String title;
  final String carMake;
  final String carModel;
  final DateTime startTime;
  final DateTime endTime;

  Booking({
    required this.title,
    required this.carMake,
    required this.carModel,
    required this.startTime,
    required this.endTime,
  });
}

final kEvents = {
  DateTime.utc(2024, 10, 24): [
    Booking(
      title: 'Battery Replacement',
      carMake: 'Chevrolet',
      carModel: 'Malibu',
      startTime: DateTime.utc(2024, 10, 24, 10),
      endTime: DateTime.utc(2024, 10, 24, 11),
    ),
    Booking(
      title: 'Brake Pad Change',
      carMake: 'Nissan',
      carModel: 'Altima',
      startTime: DateTime.utc(2024, 10, 24, 13),
      endTime: DateTime.utc(2024, 10, 24, 14),
    ),
  ],
};
