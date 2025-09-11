// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String fullname;
  final String email;
  final String phone;
  final String password;
  final String googleId;
  final String state;
  final String city;
  final String? department;
  final String address;
  final String picture;
  final List<String> authProvider;
  final String role;

  User({
    required this.fullname,
    required this.email,
    required this.phone,
    required this.googleId,
    required this.picture,
    required this.authProvider,
    required this.state,
    required this.city,
    this.department,
    required this.address,
    required this.role,
    required this.password,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'googleId': googleId,
      'picture': picture,
      'state':state,
      if (department != null) 'department': department,
      'city':city,
      'address':address,
      'password': password,
      'authProvider': authProvider,
      'role': role,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      fullname: map['fullname'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      googleId: map['googleId'] ?? '',
      picture: map['picture'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
      address: map['address'] ?? '',
      department: map['department'] ?? '',
      password: map['password'] ?? '',
      authProvider: List<String>.from((map['authProvider'] ?? [])),
      role: map['role'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
