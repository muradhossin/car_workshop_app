import 'package:car_workshop_app/features/admin/booking/screens/admin_booking_screen.dart';
import 'package:car_workshop_app/features/admin/home/screens/admin_home_screen.dart';
import 'package:car_workshop_app/features/admin/service/screens/admin_service_screen.dart';
import 'package:car_workshop_app/features/admin/profile/screens/admin_profile_screen.dart';
import 'package:car_workshop_app/features/admin/report/screens/admin_reports_screen.dart';
import 'package:car_workshop_app/features/user/cart/screens/user_cart_screen.dart';
import 'package:car_workshop_app/features/user/home/screens/user_home_screen.dart';
import 'package:car_workshop_app/features/user/order/screens/user_order_screen.dart';
import 'package:car_workshop_app/features/user/profile/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  UserDashboardState createState() => UserDashboardState();
}

class UserDashboardState extends State<UserDashboard> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Widget> _screens = [
    UserHomeScreen(),
    UserOrderScreen(),
    UserCartScreen(),
    UserProfileScreen(),
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
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
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
