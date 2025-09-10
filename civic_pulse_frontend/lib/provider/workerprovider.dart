import 'package:civic_pulse_frontend/models/user.dart';
import 'package:civic_pulse_frontend/models/worker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkerProvider extends StateNotifier<Worker?>{
  WorkerProvider():super(
      Worker(id: '',fullname: '', email: '', phone: '', picture: '',address:'',password: '',assignedReports: [],department: '')
  );


  void setWorker(String workerJson) {
    final worker = Worker.fromJson(workerJson);
    state = worker;
  }

  void signOut(){
    state = null;
  }


}

final workerProvider = StateNotifierProvider<WorkerProvider,Worker?>((ref)=>WorkerProvider());