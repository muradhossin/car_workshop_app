import 'package:car_workshop_app/features/user/cart/controllers/user_cart_controller.dart';
import 'package:car_workshop_app/features/user/cart/screens/user_cart_screen.dart';
import 'package:car_workshop_app/features/user/home/screens/user_home_screen.dart';
import 'package:car_workshop_app/features/user/order/screens/user_order_screen.dart';
import 'package:car_workshop_app/features/user/profile/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  UserDashboardState createState() => UserDashboardState();
}

class UserDashboardState extends State<UserDashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<UserCartController>().loadCart();
  }
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: GetBuilder<UserCartController>(
              builder: (cartController) {
                return cartController.services.isEmpty
                    ? Icon(Icons.shopping_cart_outlined) :
                Badge(
                  label: Text(cartController.services.length.toString()),
                  child: Icon(Icons.shopping_cart),
                );
              }
            ),
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
