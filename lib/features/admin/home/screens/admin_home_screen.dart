import 'package:car_workshop_app/features/admin/dashboard/widgets/custom_card_view.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, Admin!',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomCardView(
                      icon: Icons.car_repair,
                      title: 'Total Bookings',
                      value: '20',
                    ),
                    CustomCardView(
                      icon: Icons.person,
                      title: 'Total Mechanics',
                      value: '10',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Latest Orders',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              ListView.builder(
                itemCount: 5,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: Icon(Icons.assignment_turned_in),
                      title: Text('Order ${index + 1}'),
                      subtitle: Text('Details of order ${index + 1}.'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
