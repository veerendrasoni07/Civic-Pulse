import 'package:civic_pulse_frontend/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeptHeadProfileScreen extends ConsumerStatefulWidget {
  const DeptHeadProfileScreen({super.key});

  @override
  ConsumerState<DeptHeadProfileScreen> createState() => _DeptHeadProfileScreenState();
}

class _DeptHeadProfileScreenState extends ConsumerState<DeptHeadProfileScreen> {
  final AuthController controller = AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: ElevatedButton(
            onPressed: (){
              controller.signOut(context: context, ref: ref);
            },
            child: Text("Logout")
        ),
      ),
    );
  }
}
