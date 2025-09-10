import 'dart:convert';

class Feedback {
  final int rating;
  final String? comment;
  final String submittedBy;

  Feedback({
    required this.rating,
    required this.comment,
    required this.submittedBy,
  });

  factory Feedback.fromMap(Map<String, dynamic> map) {
    int parsedRating = 0;
    if (map['rating'] != null) {
      if (map['rating'] is int) {
        parsedRating = map['rating'];
      } else {
        parsedRating = int.tryParse(map['rating'].toString()) ?? 0;
      }
    }

    return Feedback(
      rating: parsedRating,
      comment: map['comment']?.toString(),
      submittedBy: map['submittedBy']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rating': rating,
      'comment': comment,
      'submittedBy': submittedBy,
    };
  }

  factory Feedback.fromJson(String source) =>
      Feedback.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
