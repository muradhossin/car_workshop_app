import 'package:car_workshop_app/features/auth/models/user_role.dart';

class UserModel {
  String? id;
  String? email;
  String? name;
  String? phone;
  String? role;
  String? mechanicStatus;

  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.role,
    required this.id,
    this.mechanicStatus,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      role: map['role'],
      mechanicStatus: map['role'] == UserRole.mechanic.name ? map['mechanicStatus'] : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'role': role,
      if (role == UserRole.mechanic.name) 'mechanicStatus': mechanicStatus,
    };
  }
}