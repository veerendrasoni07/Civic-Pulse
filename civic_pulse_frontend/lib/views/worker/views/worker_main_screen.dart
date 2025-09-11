import 'package:civic_pulse_frontend/provider/userprovider.dart';
import 'package:civic_pulse_frontend/views/worker/views/screen/worker_home_screen.dart';
import 'package:civic_pulse_frontend/views/worker/views/screen/worker_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkerMainScreen extends ConsumerStatefulWidget {
  const WorkerMainScreen({super.key});

  @override
  ConsumerState<WorkerMainScreen> createState() => _WorkerMainScreenState();
}

class _WorkerMainScreenState extends ConsumerState<WorkerMainScreen> {
  int selectedPage = 0;



  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final List<Widget> pages = [
      WorkerHomeScreen(),
      ProfileScreen(role: user!.role, name: user.fullname, email: user.email, phone: user.phone, id: user.id, imageUrl: user.picture)
    ];
    return Scaffold(
      body: pages[selectedPage] ,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedPage,
          onTap: (value){
            setState(() {
              selectedPage = value;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ]
      ),
    );
  }
}
