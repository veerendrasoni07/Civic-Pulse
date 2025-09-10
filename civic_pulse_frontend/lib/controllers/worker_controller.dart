import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:civic_pulse_frontend/global_variable..dart';
import 'package:civic_pulse_frontend/models/complaint_report.dart';
import 'package:civic_pulse_frontend/models/worker.dart';
import 'package:civic_pulse_frontend/service/manage_http_request.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WorkerController {


  Future<List<ComplaintReport>> getAssignedReports(String workerId) async {
    try{
      http.Response response = await http.get(
          Uri.parse('$uri/api/fetch-all-assigned-reports/$workerId'),
        headers: <String,String>{
            'Content-Type':'application/json; charset=UTF-8'
        }
      );

      if(response.statusCode == 200){
        final List<dynamic> data = jsonDecode(response.body);
        final reports = data.map((report)=>ComplaintReport.fromMap(report)).toList();
        return reports;
      }else{
        throw Exception('Failed to fetch reports ${response.statusCode}');
      }

    }catch(e){
      print(e.toString());
      throw Exception('Failed to fetch reports');
    }
  }


}