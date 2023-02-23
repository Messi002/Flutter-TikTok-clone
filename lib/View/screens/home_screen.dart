import 'package:ap2/View/widgets/custom_icon.dart';
import 'package:ap2/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pgIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              pgIdx = value;
            });
          },
          currentIndex: pgIdx,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.white,
          backgroundColor: kBackgroundColor,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 30), label: 'Search'),
            BottomNavigationBarItem(icon: CustomIcon(), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.message, size: 30), label: 'Message'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 30), label: 'Profile'),
          ]),
      body: pages[pgIdx],
    );
  }
}
