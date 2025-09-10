// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DeptHead {
  final String id;
  final String fullname;
  final String email;
  final String phone;
  final String password;
  final String googleId;
  final String department;
  final String address;
  final String picture;
  final List<String> authProvider;
  final String role;
  final String codeUsed;

  DeptHead({
    required this.fullname,
    required this.email,
    required this.phone,
    required this.googleId,
    required this.picture,
    required this.authProvider,
    required this.address,
    required this.department,
    required this.role,
    required this.password,
    required this.id,
    required this.codeUsed
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'googleId': googleId,
      'picture': picture,
      'department': department,
      'address':address,
      'password': password,
      'authProvider': authProvider,
      'role': role,
      'codeUsed':codeUsed
    };
  }

  factory DeptHead.fromMap(Map<String, dynamic> map) {
    return DeptHead(
      id: map['_id'] ?? '',
      fullname: map['fullname'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      googleId: map['googleId'] ?? '',
      picture: map['picture'] ?? '',
      department: map['department'] ?? '',
      address: map['address'] ?? '',
      password: map['password'] ?? '',
      authProvider: List<String>.from((map['authProvider'] ?? [])),
      role: map['role'] ?? '',
      codeUsed: map['codeUsed'] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

  factory DeptHead.fromJson(String source) =>
      DeptHead.fromMap(json.decode(source) as Map<String, dynamic>);
}
