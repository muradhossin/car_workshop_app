import 'package:car_workshop_app/features/admin/booking/screens/admin_booking_screen.dart';
import 'package:car_workshop_app/features/admin/home/screens/admin_home_screen.dart';
import 'package:car_workshop_app/features/admin/mechanics/screens/admin_mechanic_screen.dart';
import 'package:car_workshop_app/features/admin/service/screens/admin_service_screen.dart';
import 'package:car_workshop_app/features/admin/profile/screens/admin_profile_screen.dart';
import 'package:car_workshop_app/features/admin/report/screens/admin_reports_screen.dart';
import 'package:car_workshop_app/features/mechanic/booking/screens/mechanic_booking_screen.dart';
import 'package:car_workshop_app/features/mechanic/home/screens/mechanic_home_screen.dart';
import 'package:car_workshop_app/features/mechanic/order/screens/mechanic_order_screen.dart';
import 'package:car_workshop_app/features/mechanic/profile/screens/mechanic_profile_screen.dart';
import 'package:flutter/material.dart';

class MechanicDashboard extends StatefulWidget {
  const MechanicDashboard({super.key});

  @override
  MechanicDashboardState createState() => MechanicDashboardState();
}

class MechanicDashboardState extends State<MechanicDashboard> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Widget> _screens = [
    MechanicHomeScreen(),
    MechanicBookingScreen(),
    MechanicOrderScreen(),
    MechanicProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_repair_service),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Profile',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        backgroundColor:
        Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
      ),
    );
  }
}
