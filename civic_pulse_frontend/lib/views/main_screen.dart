import 'package:civic_pulse_frontend/views/nav_screen/home_screen.dart';
import 'package:civic_pulse_frontend/views/nav_screen/profile_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pages = [
    HomeScreen(),
    ProfileScreen()
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
        },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
          ]
      ),
    );
  }
}
