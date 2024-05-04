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
  List<int> _markedWeeks = [];
  List<int> _markedDays = [];
  late String userId;
  List<DroppedShift> _droppedShifts = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = (prefs.getInt('userId') ?? 6348).toString();
    _fetchSchedules(userId);

    List<String>? droppedShiftsJson = prefs.getStringList('droppedShifts');
    if (droppedShiftsJson != null) {
      _droppedShifts = droppedShiftsJson
          .map((shiftJson) => jsonDecode(shiftJson))
          .where((decodedShift) => decodedShift['userId'] == userId)
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
      _markPickupDays();
    } catch (e) {
      print('Error fetching schedules: $e');
    }
  }

  // Method to mark the pickup days on the calendar
  void _markPickupDays() {
    final List<DateTime> pickupDates = _schedules
        .where((schedule) => schedule.type == ScheduleType.pickup)
        .map((schedule) => DateTime.parse(schedule.dropDate!).toLocal())
        .toList();

    setState(() {
      _markedDays.addAll(pickupDates.map((date) => date.day));
      print("marked days" + _markedDays.toString());
    });
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

    final dayIndex = daysOfWeek[dayName] ?? 1;
    final dayDifference = dayIndex - initialDate.weekday;
    return initialDate.add(
        Duration(days: dayDifference < 0 ? dayDifference + 7 : dayDifference));
  }

  List<int> _getMarkedDays() {
    final markedDays = <int>[];
    final today = DateTime.now();
    final Set<String> uniqueDropDates = {}; // Keep track of unique drop dates

    for (final schedule in _schedules) {
      if (schedule.type == ScheduleType.drop) {
        final dropDate = DateTime.parse(schedule.dropDate!);
        if (dropDate.isAfter(today.subtract(const Duration(days: 1)))) {
          // Check if drop date is already marked
          final formattedDropDate =
              '${dropDate.year}-${dropDate.month}-${dropDate.day}';
          if (!uniqueDropDates.contains(formattedDropDate)) {
            markedDays.add(dropDate.weekday);
            uniqueDropDates.add(formattedDropDate);
          }
        }
      } else if (schedule.type == ScheduleType.pickup) {
        final dropDate = DateTime.parse(schedule.dropDate!);
        final pickupDay = getDayFromName(schedule.timeSlotDay, dropDate);
        if (pickupDay.isAfter(today.subtract(const Duration(days: 1))) &&
            !_markedWeeks.contains(pickupDay.weekday)) {
          markedDays.add(pickupDay.weekday);
        }
      }
    }

    setState(() {
      isReady = true;
    });

    _markedWeeks = markedDays;
    print("marked days " + _markedWeeks.toString());
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
            onDropShiftSuccess: (scheduleId, selectedDay) async {
              setState(() {
                _droppedShifts.add(DroppedShift(
                  scheduleId: scheduleId,
                  selectedDay: selectedDay,
                ));
              });
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
                    CalendarFormat.week: 'Week',
                  },
                  calendarStyle: const CalendarStyle(
                    markersMaxCount: 3,
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) {
                      final isMarked = _markedWeeks.contains(day.weekday) ||
                          _markedDays.contains(day.day);
                      final isDropDate = _schedules.any((schedule) {
                        if (schedule.type == ScheduleType.drop) {
                          final dropDay = DateTime.parse(schedule.dropDate!);
                          return isSameDay(day, dropDay) &&
                              day.day == dropDay.day;
                        }
                        return false;
                      });

                      if (isDropDate) {
                        return null;
                      }

                      if (isDropDate || !isMarked) {
                        return null;
                      }

                      return isMarked
                          ? Transform.translate(
                              offset: const Offset(0, -6),
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
                    child: _buildShiftScheduleList(),
                  ),
                const SizedBox(height: 20),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: [
                    Text(
                      'You are working with:',
                      style: TextStyle(fontSize: 16),
                    ),
                    ..._schedules
                        .map((schedule) => schedule.cafeName)
                        .toSet()
                        .toList()
                        .map((cafeName) => Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF76900),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                cafeName,
                                style: TextStyle(color: Colors.white),
                              ),
                            ))
                  ],
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _buildShiftScheduleList() {
    final hasSchedules = _schedules.any((schedule) {
      final scheduleDay = _getScheduleDay(schedule);
      return isSameDay(scheduleDay, _selectedDay);
    });

    final isMarkedDay = _markedWeeks.contains(_selectedDay!.weekday);

    if (!hasSchedules && !isMarkedDay) {
      return Center(
        child: Text(
          'No shift schedules for this day.',
          style: TextStyle(fontSize: 16),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: _schedules.length,
        itemBuilder: (context, index) {
          final schedule = _schedules[index];
          if (schedule.type == ScheduleType.drop) {
            return const SizedBox.shrink();
          } else {}

          DateTime scheduleDay = _getScheduleDay(schedule);

          bool isDropDay = _schedules.any((s) {
            return s.type == ScheduleType.drop &&
                DateTime.parse(s.dropDate!).isAtSameMomentAs(scheduleDay);
          });

          final isDropDate = _schedules.any((schedule) {
            if (schedule.type == ScheduleType.drop) {
              final dropDay = DateTime.parse(schedule.dropDate!);
              return isSameDay(scheduleDay, dropDay) &&
                  scheduleDay.day == dropDay.day;
            }
            return false;
          });

          final isDropped = _droppedShifts.any((droppedShift) =>
              droppedShift.scheduleId == schedule.scheduleId &&
              isSameDay(droppedShift.selectedDay, scheduleDay));

          if (isSameDay(scheduleDay, _selectedDay) && !isDropDate) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 50, bottom: 8),
              child: ListTile(
                tileColor: isDropped ? Colors.grey.shade300 : null,
                title: Text(schedule.cafeName),
                subtitle: Text(schedule.timeSlot),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed:
                          isDropped ? null : () => _handleDropShift(schedule),
                      child: Text(
                        'Drop Shift',
                        style: TextStyle(
                          color: isDropped ? Colors.grey : Colors.red,
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
      );
    }
  }

  DateTime _getScheduleDay(Schedule schedule) {
    switch (schedule.type) {
      case ScheduleType.pickup:
        return DateTime.parse(schedule.dropDate!);
      case ScheduleType.normal:
        return getDayFromName(schedule.timeSlotDay, _focusedDay);
      case ScheduleType.drop:
        return DateTime
            .now(); // Return any default value or handle it as per your application logic
    }
  }
}
