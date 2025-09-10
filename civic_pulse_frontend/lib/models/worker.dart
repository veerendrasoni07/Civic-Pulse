// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Worker {
  final String id;
  final String fullname;
  final String email;
  final String phone;
  final String department;
  final String address;
  final String picture;
  final String password;
  final List<String> assignedReports;

  Worker({
    required this.id,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.department,
    required this.address,
    required this.picture,
    required this.password,
    required this.assignedReports,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'department': department,
      'address': address,
      'picture': picture,
      'password': password,
      'assignedTasks': assignedReports,
    };
  }

  factory Worker.fromMap(Map<String, dynamic> map) {
    return Worker(
      id: map['_id'] ?? '',
      fullname: map['fullname'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      department: map['department'] ?? '',
      address: map['address'] ?? '',
      picture: map['picture'] ?? '',
      password: map['password'] ?? '',
      assignedReports: List<String>.from((map['assignedReports'] ?? [])),
    );
  }

  String toJson() => json.encode(toMap());

  factory Worker.fromJson(String source) => Worker.fromMap(json.decode(source) as Map<String, dynamic>);
}
