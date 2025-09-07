import 'package:civic_pulse_frontend/views/worker/views/screen/worker_home_screen.dart';
import 'package:civic_pulse_frontend/views/worker/views/screen/worker_profile_screen.dart';
import 'package:flutter/material.dart';

class WorkerMainScreen extends StatelessWidget {
  WorkerMainScreen({super.key});

  int selectedPage = 0;
  final List<Widget> pages = [
    WorkerHomeScreen(),
    WorkerProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedPage] ,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedPage,
          onTap: (value){
            selectedPage = value;
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ]
      ),
    );
  }
}
