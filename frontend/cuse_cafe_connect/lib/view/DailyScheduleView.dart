import 'package:cuse_cafe_connect/model/ScheduleManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailyScheduleView extends StatelessWidget {
  final int day;
  final List<ScheduleManager> schedules;

  DailyScheduleView({required this.day, required this.schedules});

  @override
  Widget build(BuildContext context) {
    List<ScheduleManager> dailySchedules = schedules
        .where((schedule) => _getWeekdayIndex(schedule.timeSlotDay) == day)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(getWeekdayFromIndex(day)),
      ),
      body: dailySchedules.isEmpty
          ? Center(
              child: Text('No schedules for this day'),
            )
          : Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Add border
                  borderRadius: BorderRadius.circular(8.0), // Optional: Add border radius
                ),
                padding: EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Time Slot')),
                      DataColumn(label: Text('User')),
                    ],
                    rows: dailySchedules
                        .map(
                          (schedule) => DataRow(
                            cells: [
                              DataCell(Text(schedule.timeSlot)),
                              DataCell(Text(schedule.userName ?? 'Not assigned')),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
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
