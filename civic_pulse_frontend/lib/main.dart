import 'package:civic_pulse_frontend/provider/userprovider.dart';
import 'package:civic_pulse_frontend/provider/workerprovider.dart';
import 'package:civic_pulse_frontend/provider/deptheadprovider.dart';
import 'package:civic_pulse_frontend/views/authentication/login_screen.dart';
import 'package:civic_pulse_frontend/views/main_screen.dart';
import 'package:civic_pulse_frontend/views/worker/views/worker_main_screen.dart';
import 'package:civic_pulse_frontend/views/depthead/views/dept_head_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  Future<void> checkTokenAndRole(WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('auth-token');

    // Check each role separately
    final user = prefs.getString('user');
    final worker = prefs.getString('worker');
    final deptHead = prefs.getString('dept-head');

    if (token != null) {
      if (user != null) {
        ref.read(userProvider.notifier).setUser(user);
      } else if (worker != null) {
        ref.read(workerProvider.notifier).setWorker(worker);
      } else if (deptHead != null) {
        ref.read(deptHeadProvider.notifier).setDeptHead(deptHead);
      }
    } else {
      // Clear all
      ref.read(userProvider.notifier).signOut();
      ref.read(workerProvider.notifier).signOut();
      ref.read(deptHeadProvider.notifier).signOut();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: checkTokenAndRole(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = ref.watch(userProvider);
          final worker = ref.watch(workerProvider);
          final deptHead = ref.watch(deptHeadProvider);

          if (user != null) {
            return const MainScreen();
          } else if (worker != null) {
            return const WorkerMainScreen();
          } else if (deptHead != null) {
            return const DeptHeadMainScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
