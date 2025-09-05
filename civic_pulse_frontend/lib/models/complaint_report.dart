// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ComplaintReport {
  final String id;
  final String image;
  final String location;
  final String desc;
  final String phone;
  final String department;
  final String fullname;

  ComplaintReport({required this.id, required this.image, required this.location, required this.desc, required this.phone, required this.department, required this.fullname});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'location': location,
      'desc': desc,
      'phone': phone,
      'department': department,
      'fullname': fullname,
    };
  }

  factory ComplaintReport.fromMap(Map<String, dynamic> map) {
    return ComplaintReport(
      id: map['_id'] ?? '',
      image: map['image'] ?? '',
      location: map['location'] ?? '',
      desc: map['desc'] ?? '',
      phone: map['phone'] ?? '',
      department: map['department'] ?? '',
      fullname: map['fullname'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ComplaintReport.fromJson(String source) => ComplaintReport.fromMap(json.decode(source) as Map<String, dynamic>);
}
