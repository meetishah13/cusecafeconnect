import 'package:cuse_cafe_connect/controller/TradeBoardController.dart';
import 'package:cuse_cafe_connect/view/ProfileView.dart';
import 'package:cuse_cafe_connect/view/ScheduleManagerView.dart';
import 'package:cuse_cafe_connect/view/TradeBoardManagerView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SupervisorMainScreen extends StatefulWidget {
  @override
  _SupervisorMainScreenState createState() => _SupervisorMainScreenState();
}

class _SupervisorMainScreenState extends State<SupervisorMainScreen> {
  int _selectedIndex = 0;
  TradeBoardController tbc = TradeBoardController();

  List<Widget> _widgetOptions = [];

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      ScheduleManagerView(),
      TradeBoardManagerView(tbc),
      ProfileView(),
    ];
  }

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
