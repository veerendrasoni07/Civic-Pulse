import 'package:civic_pulse_frontend/views/worker/views/screen/worker_home_screen.dart';
import 'package:civic_pulse_frontend/views/worker/views/screen/worker_profile_screen.dart';
import 'package:flutter/material.dart';

class WorkerMainScreen extends StatefulWidget {
  const WorkerMainScreen({super.key});

  @override
  State<WorkerMainScreen> createState() => _WorkerMainScreenState();
}

class _WorkerMainScreenState extends State<WorkerMainScreen> {
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
