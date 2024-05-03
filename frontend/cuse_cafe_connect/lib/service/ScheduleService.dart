import 'dart:convert';
import 'package:cuse_cafe_connect/model/ScheduleManager.dart';
import 'package:cuse_cafe_connect/model/Shift.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleService {

  // static const String _baseUrl = 'http://localhost:8080/api/schedules/user/';

  Future<List<Schedule>> fetchSchedules(String userId) async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    String? deviceType = _pref.getString('platform');
    String localhost = (deviceType == 'ios') ? 'localhost' : '10.0.2.2';

    List<Schedule> schedules = [];
    final response = await http.get(Uri.parse('http://$localhost:8080/api/schedules/user/$userId/shifts'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final scheduleList = jsonData['schedule'] as List<dynamic>;
      final pickupUsers = jsonData['pickupUser'] as List<dynamic>;
      final dropUsers = jsonData['dropUser'] as List<dynamic>;
      print("dfdf");
      print(scheduleList);
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
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    String? deviceType = _pref.getString('platform');
    String localhost = (deviceType == 'ios') ? 'localhost' : '10.0.2.2';
    final response = await http.get(Uri.parse('http://$localhost:8080/api/schedules/user/$cafeId/schedule'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<ScheduleManager> schedules = jsonList.map((json) => ScheduleManager.fromJson(json)).toList();
      return schedules;
    } else {
      throw Exception('Failed to load schedules');
    }
  }
}
