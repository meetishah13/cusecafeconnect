import 'package:cuse_cafe_connect/controller/ScheduleController.dart';
import 'package:cuse_cafe_connect/controller/UserController.dart';
import 'package:cuse_cafe_connect/model/ScheduleManager.dart';
import 'package:cuse_cafe_connect/view/DailyScheduleView.dart';
import 'package:flutter/material.dart';

class ScheduleManagerView extends StatefulWidget {
  @override
  _ScheduleManagerViewState createState() => _ScheduleManagerViewState();
}

class _ScheduleManagerViewState extends State<ScheduleManagerView> {
  ScheduleController sc = ScheduleController();
  bool _isLoading = true;
  List<ScheduleManager> _finalCafeSch = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      int cafeId = await sc.getCafeId();

      final List<ScheduleManager> schedule =
          await sc.fetchSchedulesByCafeId(cafeId);

      setState(() {
        _finalCafeSch = schedule;
        _isLoading = false;
      });
    } catch (e) {
      print('Error in view: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0.0), // Add padding
              child: Navigator(
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) {
                      return GridView.builder(
                        shrinkWrap: true, // Limit height to content size
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, // Change to 1 for one card per row
                          childAspectRatio: 7.0,
                        ),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Navigate to a new screen to display schedules for the selected day
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DailyScheduleView(
                                    day: index, // Pass the index representing the day
                                    schedules: _finalCafeSch, // Pass the list of schedules
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              color: Color(0xFFF76900),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Your widget content here
                                    Text(
                                      getWeekdayFromIndex(index),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      'Click to view schedules',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
    );
  }

  String getWeekdayFromIndex(int index) {
    switch (index) {
      case 0:
        return 'Monday';
      case 1:
        return 'Tuesday';
      case 2:
        return 'Wednesday';
      case 3:
        return 'Thursday';
      case 4:
        return 'Friday';
      default:
        return ''; // Handle out-of-range values
    }
  }
}
