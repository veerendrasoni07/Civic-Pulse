// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class History {
  final String id;
  final String status;
  final String updatedBy;
  final String note;
  final DateTime updatedAt;

  History({required this.id, required this.status, required this.updatedBy, required this.note, required this.updatedAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'updatedBy': updatedBy,
      'note': note,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory History.fromMap(Map<String, dynamic> map) {
    return History(
      id: map['_id'] as String,
      status: map['status'] as String,
      updatedBy: map['updatedBy'] as String,
      note: map['note'] as String,
      updatedAt: DateTime.parse(map['updatedAt'] ?? DateTime.now()),
    );
  }

  String toJson() => json.encode(toMap());

  factory History.fromJson(String source) => History.fromMap(json.decode(source) as Map<String, dynamic>);
}
