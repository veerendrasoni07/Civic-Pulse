import 'package:civic_pulse_frontend/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  ProfileScreen({super.key});
  final AuthController controller = AuthController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: (){
              controller.signOut(context: context, ref: ref);
            },
            child: Text("Logout")
        ),
      )
    );
  }
}
