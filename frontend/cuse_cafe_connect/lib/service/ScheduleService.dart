import 'dart:convert';
import 'package:cuse_cafe_connect/model/ScheduleManager.dart';
import 'package:cuse_cafe_connect/model/Shift.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ScheduleService {
  static const String _baseUrl = 'http://localhost:8080/api/schedules/user/';

  Future<List<Schedule>> fetchSchedules(String userId) async {
    List<Schedule> schedules = [];
    final response = await http.get(Uri.parse('$_baseUrl$userId/shifts'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final scheduleList = jsonData['schedule'] as List<dynamic>;
      final pickupUsers = jsonData['pickupUser'] as List<dynamic>;
      final dropUsers = jsonData['dropUser'] as List<dynamic>;

      // Parse normal schedules
      schedules.addAll(
          scheduleList.map((schedule) => Schedule.fromJson(schedule)).toList());

      // Add PickupUser schedules with dropDate
      schedules.addAll(pickupUsers
          .map((pickup) => Schedule.fromJson(pickup,
              type: ScheduleType.pickup,
              dropDate:
                  DateTime.parse(pickup['dropDate']).toString().split(' ')[0]))
          .toList());

      schedules.addAll(dropUsers
          .map((drop) => Schedule.fromJson(drop,
              type: ScheduleType.drop,
              dropDate:
                  DateTime.parse(drop['dropDate']).toString().split(' ')[0]))
          .toList());

      // Optionally, handle DropUser schedules, if needed
    } else {
      throw Exception('Failed to fetch schedules');
    }

    return schedules;
  }

  Future<List<ScheduleManager>> fetchSchedulesByCafeId(int cafeId) async {
  final response = await http.get(Uri.parse('http://localhost:8080/api/schedules/user/$cafeId/schedule'));

  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    List<ScheduleManager> schedules = jsonList.map((json) => ScheduleManager.fromJson(json)).toList();
    return schedules;
  } else {
    throw Exception('Failed to load schedules');
  }
}
}
