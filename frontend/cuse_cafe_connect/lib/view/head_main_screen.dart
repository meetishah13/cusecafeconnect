import 'package:cuse_cafe_connect/view/CafeView.dart';
import 'package:cuse_cafe_connect/view/LoginView.dart';
import 'package:cuse_cafe_connect/view/PendingGroupsView.dart';
import 'package:cuse_cafe_connect/view/PendingScheduleView.dart';
import 'package:cuse_cafe_connect/view/ProfileView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HeadMainScreen extends StatefulWidget {
  @override
  _HeadMainScreenState createState() => _HeadMainScreenState();
}

class _HeadMainScreenState extends State<HeadMainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    PendingGroupsView(),
    PendingScheduleView(),
    CafeView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('roleId');
    await prefs.remove('userId');

    // Navigate to LoginView
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuse Cafe Connect'),
        backgroundColor: Color(0xFFF76900),
        foregroundColor: Colors.white,// Set background color to F76900
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white, // Set signout button color to white
            ),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Group',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Cafe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFF76900),
        unselectedItemColor:
            Colors.grey, // Optional: Set the color for unselected items
        type: BottomNavigationBarType
            .fixed, // This will make the icons visible all the time
        onTap: _onItemTapped,
      ),
    );
  }
}
