import 'package:civic_pulse_frontend/provider/userprovider.dart';
import 'package:civic_pulse_frontend/views/authentication/login_screen.dart';
import 'package:civic_pulse_frontend/views/main_screen.dart';
import 'package:civic_pulse_frontend/views/worker/views/worker_main_screen.dart';
import 'package:civic_pulse_frontend/views/depthead/views/dept_head_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  Future<void> checkTokenAndUser(WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth-token');
    final userJson = prefs.getString('user');

    if (token != null && userJson != null) {
      ref.read(userProvider.notifier).setUser(userJson);
    } else {
      ref.read(userProvider.notifier).signOut();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: checkTokenAndUser(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = ref.watch(userProvider);

          if (user != null) {
            switch (user.role) {
              case "citizen":
                return const MainScreen();
              case "worker":
                return const WorkerMainScreen();
              case "depthead":
                return const DeptHeadMainScreen();
              default:
                return const LoginScreen();
            }
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
