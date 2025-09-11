import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:civic_pulse_frontend/global_variable..dart';
import 'package:civic_pulse_frontend/models/complaint_report.dart';
import 'package:civic_pulse_frontend/models/user.dart';
import 'package:civic_pulse_frontend/models/worker.dart';
import 'package:civic_pulse_frontend/service/manage_http_request.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class DepartmentHeadController {



  Future<List<ComplaintReport>> getAssignedReports(String deptHeadId) async {
    try{
      print(deptHeadId);
      http.Response response = await http.get(
          Uri.parse('$uri/api/get-assigned-reports/$deptHeadId'),
        headers: <String,String>{
            'Content-Type':'application/json; charset=UTF-8'
        }
      );

      if(response.statusCode == 200){
        final List<dynamic> data = jsonDecode(response.body);
        final List<ComplaintReport> reports = data.map((e) => ComplaintReport.fromMap(e)).toList();
        print("Decoded data: $data");
        for (var e in data) {
          print("Raw map: $e");
        }
        print(response.body);
        print(reports);
        return reports;
      }else{
        throw Exception('Failed to fetch reports ${response.statusCode}');
      }

    }catch(e){
      print(e.toString());
      throw Exception(e.toString());
    }
  }


  Future<List<User>> fetchWorkers({required String department,required String role}) async {
    try{
      http.Response response = await http.get(
          Uri.parse('$uri/api/get-depthead/$role/$department'),
          headers: <String,String>{
            'Content-Type':'application/json; charset=UTF-8'
          }
      );
      if(response.statusCode == 200){
        final List<dynamic> data = jsonDecode(response.body);
        final List<User> workers = data.map((e) => User.fromMap(e)).toList();
        return workers;
      }
      else{
        throw Exception("Failed to fetch workers :${response.statusCode}");
      }
    }catch(e){
      print("Error:$e");
      throw Exception("Failed to fetch workers :$e");
      return [];
    }
  }

  Future<void> assignReportToWorker({required List<Map<String,dynamic>> workers,required String reportId,required BuildContext context}) async {
    try{
      http.Response response = await http.post(
        Uri.parse('$uri/api/assign-reports/worker'),
        body: jsonEncode({
          'reportId':reportId,
          'workers':workers
        }),
        headers: <String,String>{
          'Content-Type':'application/json; charset=UTF-8'
        },
      );
      if(response.statusCode == 200){
        final data = jsonDecode(response.body)['message'];
        Navigator.of(context).pop();
        showSnackBar(context, 'Successfully Assigned','Tasks Assigned Successfully' , ContentType.success);
      }
      else{
        throw Exception("Failed to fetch workers :${response.statusCode}");
      }
    }catch(e){
      print("Error:$e");
      throw Exception("Failed to fetch workers :$e");
    }
  }



}