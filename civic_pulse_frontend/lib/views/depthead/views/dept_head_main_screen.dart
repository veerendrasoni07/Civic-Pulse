import 'package:civic_pulse_frontend/views/depthead/views/screen/dept_head_home_screen.dart';
import 'package:civic_pulse_frontend/views/depthead/views/screen/dept_head_profile_screen.dart';
import 'package:flutter/material.dart';

class DeptHeadMainScreen extends StatelessWidget {
  DeptHeadMainScreen({super.key});

  int selectedPage = 0;
  final List<Widget> pages = [
    DeptHeadHomeScreen(),
    DeptHeadProfileScreen(),
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
