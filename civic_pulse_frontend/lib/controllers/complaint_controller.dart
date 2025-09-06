import 'dart:convert';
import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:civic_pulse_frontend/global_variable..dart';
import 'package:civic_pulse_frontend/models/complaint_report.dart';
import 'package:civic_pulse_frontend/service/manage_http_request.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComplaintController {
  Future<void> sendComplaintReport({
    required File image,
    required String fullname,
    required String location,
    required String desc,
    required String userId,
    required String phone,
    required String department,
    required BuildContext context,
  }) async {
    try {
      final CloudinaryPublic cloudinaryPublic = CloudinaryPublic(
        "dktwuay7l",
        "Civic Pulse",
      );
      final imageByte = await image.readAsBytes();

      CloudinaryResponse? imageResponse = await cloudinaryPublic.uploadFile(
        CloudinaryFile.fromBytesData(
          imageByte,
          identifier: 'issuePic',
          folder: 'Complaint Pics',
        ),
      );

      final imageUrl = imageResponse.secureUrl;

      http.Response response = await http.post(
        Uri.parse('$uri/api/complaint-report'),
        body: jsonEncode({
          'fullname': fullname,
          'image': imageUrl,
          'userId': userId,
          'desc': desc,
          'phone': '7489339369',
          'location': location,
          'department': department,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        showSnackBar(
          context,
          'Successfully',
          'report fucked',
          ContentType.success,
        );
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e) {
      print(e.toString());
      showSnackBar(
        context,
        'Error Occurred',
        e.toString(),
        ContentType.failure,
      );
    }
  }

  Future<List<ComplaintReport>> myReports({required String userId}) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/my-reports/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<ComplaintReport> reports =
            data.map((report) => ComplaintReport.fromMap(report)).toList();
        return reports;
      } else {
        throw Exception('Something went wrong ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }
}
