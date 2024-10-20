class UserModel {
  String? id;
  String? email;
  String? name;
  String? phone;
  String? role;

  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.role,
    required this.id,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      role: map['role'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'role': role,
    };
  }
}