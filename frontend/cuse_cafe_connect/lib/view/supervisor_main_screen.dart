import 'package:cuse_cafe_connect/controller/TradeBoardController.dart';
import 'package:cuse_cafe_connect/view/LoginView.dart';
import 'package:cuse_cafe_connect/view/ProfileView.dart';
import 'package:cuse_cafe_connect/view/ScheduleManagerView.dart';
import 'package:cuse_cafe_connect/view/TradeBoardManagerView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
        backgroundColor: Color(0xFFF76900), // Set background color to F76900
        foregroundColor: Colors.white,
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
