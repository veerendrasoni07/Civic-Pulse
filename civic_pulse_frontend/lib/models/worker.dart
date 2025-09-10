// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Worker {
  final String id;
  final String fullname;
  final String email;
  final String phone;
  final String password;
  final String address;
  final String department;
  final String picture;
  final List<String> assignedReports ;

  Worker({
    required this.fullname,
    required this.email,
    required this.phone,
    required this.picture,
    required this.department,
    required this.address,
    required this.assignedReports,
    required this.password,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'picture': picture,
      'assignedReports': assignedReports,
      'department': department,
      'address':address,
      'password': password,
    };
  }

  factory Worker.fromMap(Map<String, dynamic> map) {
    return Worker(
      id: map['_id'] ?? '',
      fullname: map['fullname'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      picture: map['picture'] ?? '',
      department: map['department'] ?? '',
      address: map['address'] ?? '',
      password: map['password'] ?? '',
      assignedReports: List<String>.from((map['assignedReports'] ?? [])),
    );
  }

  String toJson() => json.encode(toMap());

  factory Worker.fromJson(String source) =>
      Worker.fromMap(json.decode(source) as Map<String, dynamic>);
}
