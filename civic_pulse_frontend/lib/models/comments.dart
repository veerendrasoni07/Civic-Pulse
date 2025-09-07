// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Comments {

  final String userId;
  final String fullname;
  final String profilePic;
  final String text;
  final DateTime createdAt;

  Comments({required this.userId, required this.fullname, required this.profilePic, required this.text, required this.createdAt});



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'fullname': fullname,
      'profilePic': profilePic,
      'text': text,
      'createdAt': createdAt.toIso8601String(), // ✅ FIX
    };
  }

  factory Comments.fromMap(Map<String, dynamic> map) {
    return Comments(
      userId: map['userId'] ?? '',
      fullname: map['fullname'] ?? '',
      profilePic: map['profilePic'] ?? '',
      text: map['text'] ?? '',
      createdAt: DateTime.parse(map['createdAt']), // ✅ FIX
    );
  }

  String toJson() => json.encode(toMap());

  factory Comments.fromJson(String source) => Comments.fromMap(json.decode(source) as Map<String, dynamic>);
}
