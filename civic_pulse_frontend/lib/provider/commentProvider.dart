import 'dart:convert';

import 'package:civic_pulse_frontend/global_variable..dart';
import 'package:civic_pulse_frontend/models/comments.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class Commentprovider extends StateNotifier<List<Comments>> {
  Commentprovider() : super([]);


  Future<void> getComments(String reportId) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/get-comments/$reportId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<Comments> comments =
            data.map((comment) => Comments.fromMap(comment)).toList();
        state = comments;
      }
    } catch (e) {
      print(e.toString());
    }
  }


  void addComment(Comments comment){
    state = [...state,comment];
  }



}


final commentProvider =
    StateNotifierProvider<Commentprovider, List<Comments>>(
      (ref) => Commentprovider(),
    );
