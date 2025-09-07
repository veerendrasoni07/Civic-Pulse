// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:civic_pulse_frontend/models/comments.dart';

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
  final List<Comments> comments;
  final String department;
  final String fullname;

  ComplaintReport({required this.id, required this.image, required this.location, required this.desc, required this.phone, required this.department, required this.fullname, required this.userId,required this.status ,required this.profilePic, this.upvote = 0, required this.createdAt,this.comments = const [],});

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
      'comments': comments.map((x) => x.toMap()).toList(),
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
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now()),
      phone: map['phone'] ?? '',
      comments: List<Comments>.from((map['comments'] ?? []).map((x) => Comments.fromMap(x))),
      department: map['department'] ?? '',
      fullname: map['fullname'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ComplaintReport.fromJson(String source) => ComplaintReport.fromMap(json.decode(source) as Map<String, dynamic>);
}
