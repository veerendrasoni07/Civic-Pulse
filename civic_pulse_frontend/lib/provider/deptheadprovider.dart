import 'package:civic_pulse_frontend/models/dept_head.dart';
import 'package:civic_pulse_frontend/models/user.dart';
import 'package:civic_pulse_frontend/models/worker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeptHeadProvider extends StateNotifier<DeptHead?>{
  DeptHeadProvider():super(
      DeptHead(id: '',fullname: '', email: '', phone: '', picture: '',address:'',password: '',department: '',codeUsed: '' ,authProvider: [], googleId: '', role: '')
  );


  void setDeptHead(String deptHeadJson) {
    final deptHead = DeptHead.fromJson(deptHeadJson);
    state = deptHead;
  }

  void signOut(){
    state = null;
  }


}

final deptHeadProvider = StateNotifierProvider<DeptHeadProvider,DeptHead?>((ref)=>DeptHeadProvider());