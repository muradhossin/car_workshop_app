import 'package:car_workshop_app/core/utils.dart';
import 'package:car_workshop_app/features/admin/mechanics/controllers/admin_mechanic_controller.dart';
import 'package:car_workshop_app/features/admin/mechanics/widgets/mechanic_card_view_widget.dart';
import 'package:car_workshop_app/features/auth/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminMechanicScreen extends StatelessWidget {
  const AdminMechanicScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mechanics'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Approved'),
              Tab(text: 'Rejected'),
            ],
          ),
        ),
        body: GetBuilder<AdminMechanicController>(
            builder: (mechanicController) {
              return TabBarView(
                children: [
                  StreamBuilder<List<UserModel>>(
                    stream: mechanicController.getPendingMechanics(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No data found.'));
                      }

                      final data = snapshot.data!;

                      return ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final mechanic = data[index];
                          return MechanicCardViewWidget(
                            onTap: () {

                            },
                            mechanic: mechanic,
                            onStatusChanged: (status) {
                              _showConfirmationDialog(context, mechanic, status, mechanicController);
                            },
                          );
                        },
                      );
                    },
                  ),

                  StreamBuilder<List<UserModel>>(
                    stream: mechanicController.getApprovedMechanics(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No data found.'));
                      }

                      final data = snapshot.data!;

                      return ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final mechanic = data[index];
                          return MechanicCardViewWidget(
                            onTap: () {

                            },
                            mechanic: mechanic,
                            onStatusChanged: (status) {
                              _showConfirmationDialog(context, mechanic, status, mechanicController);
                            },
                          );
                        },
                      );
                    },
                  ),

                  StreamBuilder<List<UserModel>>(
                    stream: mechanicController.getRejectedMechanics(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No data found.'));
                      }

                      final data = snapshot.data!;

                      return ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final mechanic = data[index];
                          return MechanicCardViewWidget(
                            onTap: () {

                            },
                            mechanic: mechanic,
                            onStatusChanged: (status) {
                              _showConfirmationDialog(context, mechanic, status, mechanicController);
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            }
        ),
      ),
    );
  }
  void _showConfirmationDialog(BuildContext context, UserModel mechanic, String newStatus, AdminMechanicController mechanicController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Status Change'),
          content: Text('Are you sure you want to change the status of ${mechanic.name} to $newStatus?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                if(mechanic.mechanicStatus != newStatus) {
                  mechanicController.updateMechanicStatus(mechanic, newStatus);
                } else{
                  showCustomSnacker('error', 'Status is already $newStatus', isError: true);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
