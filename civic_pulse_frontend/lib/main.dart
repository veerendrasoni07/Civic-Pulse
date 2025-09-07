import 'package:civic_pulse_frontend/provider/userprovider.dart';
import 'package:civic_pulse_frontend/views/authentication/login_screen.dart';
import 'package:civic_pulse_frontend/views/authentication/sign_up_screen.dart';
import 'package:civic_pulse_frontend/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    Future<void> checkTokenAndUser()async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('auth-token');
      String? user = preferences.getString('user');
      if(token!=null && user!=null){
        ref.read(userProvider.notifier).setUser(user);
      }
      else{
        ref.read(userProvider.notifier).signOut();
      }
    }

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
        home: SignupScreen()
      //FutureBuilder(
      //     future: checkTokenAndUser(),
      //     builder: (context,snapshot){
      //       if(snapshot.connectionState == ConnectionState.waiting){
      //         return Center(child: CircularProgressIndicator(),);
      //       }
      //       final user = ref.watch(userProvider);
      //       return user != null ? MainScreen() : LoginScreen();
      //     }
      // ),
    );
  }
}
