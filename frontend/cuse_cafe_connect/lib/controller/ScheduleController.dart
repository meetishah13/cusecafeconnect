import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/PendingSchedule.dart';

import 'package:cuse_cafe_connect/model/ScheduleManager.dart';
import 'package:cuse_cafe_connect/model/UserModel.dart';
import 'package:cuse_cafe_connect/service/ScheduleService.dart';
import 'package:cuse_cafe_connect/service/UserService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleController {
  final ScheduleService ss = ScheduleService();
  final UserService us = UserService();

  Future<List<PendingSchedule>> fetchPendingSchedules() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    String? device = _pref.getString('platform');
    String localhost = (device == 'ios') ? 'localhost' : '10.0.2.2';
    final response = await http.get(
        Uri.parse('http://$localhost:8080/api/schedules/pendingSchedules'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((e) => PendingSchedule.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load pending schedules');
    }
  }

  Future<bool> acceptSchedule(int scheduleId, String comment) async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    String? device = _pref.getString('platform');
    String localhost = (device == 'ios') ? 'localhost' : '10.0.2.2';
    try {
      final response = await http.put(Uri.parse(
          'http://$localhost:8080/api/schedules/accept/$scheduleId/$comment'));
      return response.statusCode == 200;
    } catch (e) {
      print('Error accepting schedule: $e');
      return false;
    }
  }

  Future<List<ScheduleManager>> fetchSchedulesByCafeId(int cafeId) async {
    return await ss.fetchSchedulesByCafeId(cafeId);
  }

  Future<bool> rejectSchedule(int scheduleId, String comment) async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    String? device = _pref.getString('platform');
    String localhost = (device == 'ios') ? 'localhost' : '10.0.2.2';
    try {
      final response = await http.put(Uri.parse(
          'http://$localhost:8080/api/schedules/reject/$scheduleId/$comment'));
      return response.statusCode == 200;
    } catch (e) {
      print('Error rejecting schedule: $e');
      return false;
    }
  }

  Future<int> getCafeId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId') ?? 3;
    UserModel? user = await us.getProfileDetails(userId);
    return user?.cafeID ?? -1;
  }
}
