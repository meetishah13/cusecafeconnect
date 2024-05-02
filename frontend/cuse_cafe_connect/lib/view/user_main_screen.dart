import 'package:cuse_cafe_connect/view/ProfileView.dart';
import 'package:cuse_cafe_connect/view/TradeBoardHome.dart';
import 'package:cuse_cafe_connect/view/stu_cafe_group_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'calendar_view.dart';

class UserMainScreen extends StatefulWidget {
  @override
  _UserMainScreenState createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    // Replace these with your actual tab views
    CalendarView(),
    StuCafeGroupView(), // Assuming this is the Groups tab
    TradeBoardHome(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: Text('My App'),
          ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'TradeBoard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor:
            Colors.grey, // Optional: Set the color for unselected items
        type: BottomNavigationBarType
            .fixed, // This will make the icons visible all the time
        onTap: _onItemTapped,
      ),
    );
  }
}
