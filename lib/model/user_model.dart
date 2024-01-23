import 'dart:convert';

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final int id;
  final int pin;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.phoneNumber,
    required this.email,
    required this.pin,
    required this.createdAt,
    required this.updatedAt,
  });

  UserModel copyWith({
    String? firstName,
    String? email,
    String? lastName,
    String? phoneNumber,
    int? id,
    int? pin,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      id: id ?? this.id,
      pin: pin ?? this.pin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'id': id,
      'email': email,
      'pin': pin,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    try {
      return UserModel(
        firstName: map['firstName'] ?? '',
        id: map['id']?.toInt() ?? 0,
        lastName: map['lastName'] ?? '',
        email: map['email'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        pin: map["pin"] ?? '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    } catch (e) {
      rethrow;
    }
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, pin: $pin, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.pin == pin &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        id.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        pin.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
