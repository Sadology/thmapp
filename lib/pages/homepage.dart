import 'package:flutter/material.dart';
import 'package:thm/components/bottom_navbar.dart';
import 'package:thm/pages/mainPage.dart';
import 'package:thm/pages/classPage.dart';
import 'package:thm/pages/noticePage.dart';
import 'package:thm/pages/routinePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  void navigationBottombar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> pages = [
    const CoursePage(),
    const ClassPage(),
    const routinePage(),
    const noticePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavBar(
          onTabChange: (index) => navigationBottombar(index),
        ),
        body: pages[selectedIndex]);
  }
}
