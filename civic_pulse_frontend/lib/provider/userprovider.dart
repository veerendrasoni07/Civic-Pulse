import 'package:civic_pulse_frontend/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProvider extends StateNotifier<User?>{
  UserProvider():super(
    User(id: '',fullname: '', email: '', phone: '', googleId: '', picture: '',state: '',city:'',address:'',password: '', authProvider: [], role: '')
  );


  void setUser(String userJson) {
    final user = User.fromJson(userJson);
    state = user;
  }

  void signOut(){
    state = null;
  }


}

final userProvider = StateNotifierProvider<UserProvider,User?>((ref)=>UserProvider());