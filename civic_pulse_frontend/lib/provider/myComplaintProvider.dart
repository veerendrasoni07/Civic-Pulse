import 'package:civic_pulse_frontend/models/complaint_report.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyComplaintProvider extends StateNotifier<List<ComplaintReport>>{
  MyComplaintProvider() : super([]);


  void addComplaint(ComplaintReport complaint){
    state = [...state,complaint];
  }



}

final myReportProvider = StateNotifierProvider<MyComplaintProvider,List<ComplaintReport>>((ref) => MyComplaintProvider());