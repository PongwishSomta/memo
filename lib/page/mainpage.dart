import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memo/page/activity.dart';
import 'package:memo/page/alert.dart';
import 'package:memo/page/home.dart';
import 'package:memo/page/medical.dart';
import 'package:memo/page/profile.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    Home(),
    Medical(),
    Activity(),
    Profile(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body:pageList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'HOME'),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule_rounded), label: 'TIMER'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_turned_in_rounded),
              label: 'ACTIVITY'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded), label: 'PROFLIE'),
        ],
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
      ),
    );
  }
}
