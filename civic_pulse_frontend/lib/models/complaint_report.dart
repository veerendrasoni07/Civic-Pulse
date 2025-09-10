import 'dart:convert';

import 'package:civic_pulse_frontend/models/comments.dart';
import 'package:civic_pulse_frontend/models/feedback.dart';
import 'package:civic_pulse_frontend/models/history.dart';

class ComplaintReport {
  final String id;
  final String image;
  final String userId;
  final String location;
  final String desc;
  final DateTime createdAt;
  final String profilePic;
  final bool escalated;
  final Map<String, dynamic> assignedHead;
  final List<Map<String, dynamic>> assignedTo;
  final List<History> history;
  final String status;
  final int upvote;
  final String phone;
  final List<Comments> comments;
  final String department;
  final String fullname;
  final String? completionImage;
  final Feedback? feedback;
  final DateTime updatedAt;

  ComplaintReport({
    required this.id,
    required this.image,
    required this.location,
    required this.desc,
    required this.phone,
    required this.department,
    required this.fullname,
    required this.userId,
    required this.status,
    required this.escalated,
    required this.profilePic,
    required this.assignedHead,
    required this.assignedTo,
    required this.history,
    this.upvote = 0,
    this.comments = const [],
    this.completionImage,
    this.feedback,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ComplaintReport.fromMap(Map<String, dynamic> map) {
    // Safe upvote parsing
    int parsedUpvote = 0;
    if (map['upvote'] != null) {
      if (map['upvote'] is int) {
        parsedUpvote = map['upvote'];
      } else {
        parsedUpvote = int.tryParse(map['upvote'].toString()) ?? 0;
      }
    }

    return ComplaintReport(
      id: map['_id']?.toString() ?? '',
      image: map['image']?.toString() ?? '',
      location: map['location']?.toString() ?? '',
      desc: map['desc']?.toString() ?? '',
      userId: map['userId']?.toString() ?? '',
      profilePic: map['profilePic']?.toString() ?? '',
      escalated: map['escalated'] ?? false,
      assignedHead: map['assignedHead'] is Map
          ? Map<String, dynamic>.from(map['assignedHead'])
          : {},
      assignedTo: map['assignedTo'] is List
          ? List<Map<String, dynamic>>.from(
          map['assignedTo'].map((x) => Map<String, dynamic>.from(x)))
          : [],
      history: map['history'] is List
          ? List<History>.from(map['history'].map((x) => History.fromMap(x)))
          : [],
      status: map['status']?.toString() ?? '',
      upvote: parsedUpvote,
      phone: map['phone']?.toString() ?? '',
      comments: map['comments'] is List
          ? List<Comments>.from(
          map['comments'].map((x) => Comments.fromMap(x)))
          : [],
      department: map['department']?.toString() ?? '',
      fullname: map['fullname']?.toString() ?? '',
      completionImage: map['completionImage']?.toString(),
      feedback: map['feedback'] != null
          ? Feedback.fromMap(Map<String, dynamic>.from(map['feedback']))
          : null,
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? DateTime.tryParse(map['updatedAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'location': location,
      'desc': desc,
      'phone': phone,
      'profilePic': profilePic,
      'assignedHead': assignedHead,
      'escalated': escalated,
      'assignedTo': assignedTo,
      'history': history.map((x) => x.toMap()).toList(),
      'status': status,
      'upvote': upvote,
      'comments': comments.map((x) => x.toMap()).toList(),
      'department': department,
      'fullname': fullname,
      'completionImage': completionImage,
      'feedback': feedback?.toMap(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'userId': userId,
    };
  }

  factory ComplaintReport.fromJson(String source) =>
      ComplaintReport.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}