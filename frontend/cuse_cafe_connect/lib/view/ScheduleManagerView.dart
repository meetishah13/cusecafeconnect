import 'package:cuse_cafe_connect/controller/ScheduleController.dart';
import 'package:cuse_cafe_connect/controller/UserController.dart';
import 'package:cuse_cafe_connect/model/ScheduleManager.dart'; // Ensure this import is correct
import 'package:cuse_cafe_connect/model/UserModel.dart';
import 'package:cuse_cafe_connect/service/UserService.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

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
          : GroupedListView<dynamic, String>(
              elements: _finalCafeSch,
              groupBy: (element) =>
                  _getWeekdayIndex(element.timeSlotDay).toString(), // Convert int to String
              groupComparator: (group1, group2) =>
                  _getWeekdayIndex(group1).compareTo(_getWeekdayIndex(group2)),
              groupSeparatorBuilder: (String groupByValue) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(getWeekdayFromIndex(int.parse(groupByValue))),
              ),
              itemBuilder: (context, dynamic element) {
                ScheduleManager schedule = element;
                return ListTile(
                  title: Text(schedule.timeSlot),
                  subtitle:
                      Text('User: ${schedule.userName ?? 'Not assigned'}'),
                );
              },
              order: GroupedListOrder.ASC,
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
    case 5:
      return 'Saturday';
    case 6:
      return 'Sunday';
    default:
      return ''; // Handle out-of-range values
  }
}


  int _getWeekdayIndex(String? weekday) {
    switch (weekday) {
      case 'Monday':
        return 0;
      case 'Tuesday':
        return 1;
      case 'Wednesday':
        return 2;
      case 'Thursday':
        return 3;
      case 'Friday':
        return 4;
      case 'Saturday':
        return 5;
      case 'Sunday':
        return 6;
      default:
        return 7; // For unknown or null values
    }
  }
}
