import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/PendingSchedule.dart';


class ScheduleController {
  Future<List<PendingSchedule>> fetchPendingSchedules() async {
    final response = await http.get(Uri.parse('http://localhost:8080/api/schedules/pendingSchedules'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((e) => PendingSchedule.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load pending schedules');
    }
  }



  Future<bool> acceptSchedule(int scheduleId,String comment) async {
    try {
      final response = await http.put(Uri.parse('http://localhost:8080/api/schedules/accept/$scheduleId/$comment'));
      return response.statusCode == 200;
    } catch (e) {
      print('Error accepting schedule: $e');
      return false;
    }
  }

  Future<bool> rejectSchedule(int scheduleId,String comment) async {
    try {
      final response = await http.put(Uri.parse('http://localhost:8080/api/schedules/reject/$scheduleId/$comment'));
      return response.statusCode == 200;
    } catch (e) {
      print('Error rejecting schedule: $e');
      return false;
    }
  }


}

