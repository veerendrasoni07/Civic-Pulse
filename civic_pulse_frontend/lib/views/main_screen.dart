import 'package:civic_pulse_frontend/provider/userprovider.dart';
import 'package:civic_pulse_frontend/views/nav_screen/home_screen.dart';
import 'package:civic_pulse_frontend/views/Widgets/profile_screen.dart';
import 'package:civic_pulse_frontend/views/nav_screen/reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {


  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    List<Widget> pages = [
      HomeScreen(),
      ProfileScreen(role: user!.role, name: user.fullname, email: user.email, phone: user.phone, id: user.id, profilePic: user.picture)
    ];
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
