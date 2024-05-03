import 'dart:convert';

import 'package:cuse_cafe_connect/model/DroppedShift.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cuse_cafe_connect/model/Shift.dart';
import 'package:cuse_cafe_connect/service/ScheduleService.dart';
import 'package:cuse_cafe_connect/view/drop_shift_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  final _scheduleService = ScheduleService();
  List<Schedule> _schedules = [];
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool isReady = false;
  List<int> _markedDays = [];

  late String userId;
  List<DroppedShift> _droppedShifts = []; //dropped shift check

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // _loadData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   userId = (prefs.getInt('userId') ?? 6348).toString();
  //   _fetchSchedules(userId);
  //   // Other initialization logic can go here
  // }

  //shared pref
  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = (prefs.getInt('userId') ?? 6348).toString();
    _fetchSchedules(userId);

    // Retrieve dropped shifts from shared preferences
    List<String>? droppedShiftsJson = prefs.getStringList('droppedShifts');
    if (droppedShiftsJson != null) {
      _droppedShifts = droppedShiftsJson
          .map((shiftJson) => jsonDecode(shiftJson))
          .where((decodedShift) =>
              decodedShift['userId'] == userId) // Check if the userId matches
          .map((filteredShift) => DroppedShift.fromJson(filteredShift))
          .toList();
    }
  }

  Future<void> _fetchSchedules(String userId) async {
    try {
      final schedules = await _scheduleService.fetchSchedules(userId);
      setState(() {
        _schedules = schedules;
      });
      _getMarkedDays();
    } catch (e) {
      print('Error fetching schedules: $e');
    }
  }

  DateTime getDayFromName(String dayName, DateTime initialDate) {
    final daysOfWeek = {
      'Monday': 1,
      'Tuesday': 2,
      'Wednesday': 3,
      'Thursday': 4,
      'Friday': 5,
      'Saturday': 6,
      'Sunday': 7,
    };

    final dayIndex = daysOfWeek[dayName] ??
        1; // Default to Monday if the day name is not found
    final dayDifference = dayIndex - initialDate.weekday;
    return initialDate.add(
        Duration(days: dayDifference < 0 ? dayDifference + 7 : dayDifference));
  }

  List<int> _getMarkedDays() {
    print("in get");
    final markedDays = <int>[];
    final today = DateTime.now();

    print("Schedules: $_schedules");

    for (final schedule in _schedules) {
      DateTime drop_day;
      if (schedule.type == ScheduleType.drop) {
        continue;
        // drop_day =
        //     DateTime.parse(schedule.dropDate!); // Skip drop schedules entirely
      }

      DateTime day;
      if (schedule.type == ScheduleType.pickup) {
        // For pickup types, use the specific date and do not repeat
        day = DateTime.parse(schedule.dropDate!); // Assuming dropDate is valid
      } else {
        // For normal types, calculate the date cyclically based on the weekday name
        day = getDayFromName(schedule.timeSlotDay, today);
      }

      String date =
          "${day.year.toString()}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";

      // Add the day to marked days if it's in the future
      if (day.isAfter(today.subtract(const Duration(days: 1)))) {
        markedDays.add(day.weekday);
      }
    }

    setState(() {
      isReady = true;
    });

    _markedDays = markedDays;

    return markedDays;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  Schedule? _selectedSchedule;

  void _handleDropShift(Schedule schedule) async {
    final scheduleId = schedule.scheduleId;
    final cafeId = schedule.cafeId;
    final date = _selectedDay.toString();
    const subTypeId = 1;
    const isAccepted = 0;
    final timeSlot = schedule.timeSlot;
    final cafeName = schedule.cafeName;

    // Print the details
    print('Schedule ID: $scheduleId');
    print('Cafe ID: $cafeId');
    print('Date: $date');
    print('SubType ID: $subTypeId');
    print('Time Slot: $timeSlot');
    print('Cafe Name: $cafeName');
    print('User ID: $userId');
    setState(() {
      _selectedSchedule = schedule;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DropShiftScreen(
            schedule: schedule,
            selectedDay: _selectedDay!,
            userId: userId,
            scheduleId: scheduleId,
            cafeId: cafeId,
            date: date,
            subTypeId: subTypeId,
            timeSlot: timeSlot,
            cafeName: cafeName,
            isAccepted: isAccepted,
            ////dropped shift check
            onDropShiftSuccess: (scheduleId, selectedDay) async {
              setState(() {
                _droppedShifts.add(DroppedShift(
                  scheduleId: scheduleId,
                  selectedDay: selectedDay,
                ));
              });
              //shred pref
              SharedPreferences prefs = await SharedPreferences.getInstance();
              List<String> droppedShiftsJson = _droppedShifts
                  .map(_droppedShiftToJson)
                  .map((json) => jsonEncode(json))
                  .toList();
              await prefs.setStringList('droppedShifts', droppedShiftsJson);
            }),
      ),
    );
  }

//shared pref
  Map<String, dynamic> _droppedShiftToJson(DroppedShift droppedShift) {
    return {
      'scheduleId': droppedShift.scheduleId,
      'selectedDay': droppedShift.selectedDay.toIso8601String(),
      'userId': userId,
    };
  }

  Future<void> _clearDroppedShifts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('droppedShifts');
    setState(() {
      _droppedShifts.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    //final markedDays = _getMarkedDays();

    return Scaffold(
      body: isReady
          ? Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.now().subtract(const Duration(days: 365)),
                  lastDay: DateTime.now().add(const Duration(days: 365)),
                  focusedDay: _focusedDay,
                  calendarFormat: CalendarFormat.week,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: _onDaySelected,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  availableCalendarFormats: const {
                    CalendarFormat.week:
                        'Week', // This limits the calendar to only month view
                  },
                  calendarStyle: const CalendarStyle(
                    markersMaxCount: 3,
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) {
                      //String d =
                      //"${day.year.toString()}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
                      final isMarked = _markedDays.contains(day.weekday);
                      // Check if the day is associated with a drop schedule
                      final isDropDate = _schedules.any((schedule) {
                        if (schedule.type == ScheduleType.drop) {
                          final dropDay = DateTime.parse(schedule.dropDate!);
                          return isSameDay(day, dropDay) &&
                              day.day == dropDay.day;
                        }
                        return false;
                      });

                      // Do not mark if it's a drop date
                      if (isDropDate) {
                        return null;
                      }

                      // Return null if the day is a drop date or if it's not marked
                      if (isDropDate || !isMarked) {
                        return null;
                      }
                      print("Day: ${day.weekday}");
                      print(_markedDays);

                      return isMarked
                          ? Transform.translate(
                              offset:
                                  const Offset(0, -6), // Adjust the offset here
                              child: Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF76900),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    day.day.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ))
                          : null;
                    },
                  ),
                ),
                if (_selectedDay != null)
                  Expanded(
                    child: ListView.builder(
                      itemCount: _schedules.length,
                      itemBuilder: (context, index) {
                        final schedule = _schedules[index];

                        // Skip displaying if the schedule type is 'drop'
                        print("drop : ${schedule.type}");
                        if (schedule.type == ScheduleType.drop) {
                          return const SizedBox.shrink();
                        } else {}

                        // Determine the correct day for each schedule
                        DateTime scheduleDay;
                        if (schedule.type == ScheduleType.pickup) {
                          scheduleDay = DateTime.parse(
                              schedule.dropDate!); // use the exact date
                        } else if (schedule.type == ScheduleType.normal) {
                          scheduleDay = getDayFromName(schedule.timeSlotDay,
                              _focusedDay); // calculate based on weekday
                        } else {
                          return const SizedBox.shrink();
                        }

                        // Check if the current scheduleDay corresponds to a 'drop' date
                        bool isDropDay = _schedules.any((s) {
                          print("ddd: ${s.dropDate}");
                          print("aaa: $scheduleDay");
                          return s.type == ScheduleType.drop &&
                              DateTime.parse(s.dropDate!)
                                  .isAtSameMomentAs(scheduleDay);
                        });

                        final isDropDate = _schedules.any((schedule) {
                          if (schedule.type == ScheduleType.drop) {
                            final dropDay = DateTime.parse(schedule.dropDate!);
                            return isSameDay(scheduleDay, dropDay) &&
                                scheduleDay.day == dropDay.day;
                          }
                          return false;
                        });

                        //drop shift check
                        final isDropped = _droppedShifts.any((droppedShift) =>
                            droppedShift.scheduleId == schedule.scheduleId &&
                            isSameDay(droppedShift.selectedDay, scheduleDay));

                        //print("isDrop: $isDropDay");

                        // Only display if the selected day matches the schedule day and it's not a drop day
                        if (isSameDay(scheduleDay, _selectedDay) &&
                            !isDropDate) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 50, bottom: 8),
                            child: ListTile(
                              //
                              tileColor: isDropped
                                  ? Colors.grey.shade300
                                  : null, // shift drop check
                              //
                              title: Text(schedule.cafeName),
                              subtitle: Text(schedule.timeSlot),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton(
                                    //onPressed: () => _handleDropShift(schedule),
                                    onPressed: isDropped
                                        ? null
                                        : () => _handleDropShift(schedule),
                                    // Implement the action for dropping the shift

                                    child: Text(
                                      'Drop Shift',
                                      //style: TextStyle(color: Colors.red),
                                      style: TextStyle(
                                        color: isDropped
                                            ? Colors.grey
                                            : Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                // if (_droppedShifts.isNotEmpty)
                //   Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: ElevatedButton(
                //       onPressed: _clearDroppedShifts,
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: const Color(
                //             0xFFF76900), // Set button color to orange
                //       ),
                //       child: Text(
                //         'Clear Dropped Shifts',
                //         style: TextStyle(
                //           color: Colors.white, // Set text color to white
                //         ),
                //       ),
                //     ),
                //   ),
                const SizedBox(height: 20),
                Text(
                  'Registered shift days for every week:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10, // Adjust the gap between boxes
                  children: _schedules
                      .where((schedule) => schedule.type == ScheduleType.normal)
                      .map((schedule) => Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF76900),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              schedule.timeSlotDay,
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                      .toList(),
                )
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
