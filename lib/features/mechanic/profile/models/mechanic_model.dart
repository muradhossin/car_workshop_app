class MechanicModel {
  final String? mechanicId;
  final String? name;
  final String? phoneNumber;
  final String? email;

  MechanicModel({
    this.mechanicId,
    this.name,
    this.phoneNumber,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'mechanicId': mechanicId,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }
}