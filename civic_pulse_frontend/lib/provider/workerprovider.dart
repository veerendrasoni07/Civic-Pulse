import 'package:civic_pulse_frontend/models/user.dart';
import 'package:civic_pulse_frontend/models/woker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkerProvider extends StateNotifier<Worker?>{
  WorkerProvider():super(
      Worker(id: '',fullname: '', email: '', phone: '', googleId: '', picture: '',address:'',password: '', authProvider: [],assignedReports: [],department: '', role: '')
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