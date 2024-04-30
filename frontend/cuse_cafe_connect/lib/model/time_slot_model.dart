import 'dart:convert';
import 'package:http/http.dart' as http;

class TimeSlot {
  final int timeSlotId;
  final String timeSlotDay;
  final String timeSlot;

  TimeSlot({required this.timeSlotId, required this.timeSlotDay, required this.timeSlot});

  factory TimeSlot.fromJson(List<dynamic> json) {
    return TimeSlot(
      timeSlotId: json[0] as int,
      timeSlotDay: json[2] as String,
      timeSlot: json[1] as String,
    );
  }
}