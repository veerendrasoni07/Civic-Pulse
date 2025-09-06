// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ComplaintReport {
  final String id;
  final String image;
  final String userId;
  final String location;
  final String desc;
  final DateTime createdAt;
  final String profilePic;
  final String status;
  final int upvote;
  final String phone;
  final String department;
  final String fullname;

  ComplaintReport({required this.id, required this.image, required this.location, required this.desc, required this.phone, required this.department, required this.fullname, required this.userId,required this.status ,required this.profilePic, required this.upvote, required this.createdAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'location': location,
      'desc': desc,
      'phone': phone,
      'profilePic': profilePic,
      'status': status,
      'upvote': upvote,
      'createdAt': createdAt.toIso8601String(),
      'userId': userId,
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
      userId: map['userId'] ?? '',
      profilePic: map['profilePic'] ?? '',
      status: map['status'] ?? '',
      upvote: map['upvote'] ?? '',
      createdAt: DateTime.parse(map['createdAt'] ?? ''),
      phone: map['phone'] ?? '',
      department: map['department'] ?? '',
      fullname: map['fullname'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ComplaintReport.fromJson(String source) => ComplaintReport.fromMap(json.decode(source) as Map<String, dynamic>);
}
