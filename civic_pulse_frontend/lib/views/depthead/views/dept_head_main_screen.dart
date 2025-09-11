import 'package:civic_pulse_frontend/provider/userprovider.dart';
import 'package:civic_pulse_frontend/views/depthead/views/screen/dept_head_home_screen.dart';
import 'package:civic_pulse_frontend/views/Widgets/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeptHeadMainScreen extends ConsumerStatefulWidget {
  const DeptHeadMainScreen({super.key});

  @override
  ConsumerState<DeptHeadMainScreen> createState() => _DeptHeadMainScreenState();
}

class _DeptHeadMainScreenState extends ConsumerState<DeptHeadMainScreen> {
  int selectedPage = 0;



  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final List<Widget> pages = [
      DeptHeadHomeScreen(),
      ProfileScreen(role: user!.role, name: user.fullname, email: user.email, phone: user.phone, id: user.id, profilePic: user.picture)
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
