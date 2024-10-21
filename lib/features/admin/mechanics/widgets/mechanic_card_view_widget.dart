import 'package:car_workshop_app/core/utils.dart';
import 'package:car_workshop_app/features/admin/mechanics/controllers/admin_mechanic_controller.dart';
import 'package:car_workshop_app/features/mechanic/profile/models/mechanic_status.dart';
import 'package:flutter/material.dart';
import 'package:car_workshop_app/features/auth/models/user_model.dart';

class MechanicCardViewWidget extends StatelessWidget {
  final UserModel mechanic;
  final VoidCallback onTap;
  final Function(String) onStatusChanged;

  const MechanicCardViewWidget({
    Key? key,
    required this.mechanic,
    required this.onTap,
    required this.onStatusChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? selectedStatus = mechanic.mechanicStatus;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mechanic.name ?? 'N/A',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('Email: ${mechanic.email ?? 'N/A'}'),
              Text('Phone: ${mechanic.phone ?? 'N/A'}'),
              const SizedBox(height: 12),
              DropdownButton<String>(
                value: selectedStatus,
                isExpanded: true,
                items: [
                  MechanicStatus.pending.name,
                  MechanicStatus.approved.name,
                  MechanicStatus.rejected.name
                ].map((status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(capitalize(status)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    selectedStatus = newValue;
                    onStatusChanged(newValue);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}



