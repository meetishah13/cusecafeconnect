import 'package:cuse_cafe_connect/model/ScheduleManager.dart';
import 'package:cuse_cafe_connect/model/UserModel.dart';
import 'package:cuse_cafe_connect/service/ScheduleService.dart';
import 'package:cuse_cafe_connect/service/UserService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleController {
  final ScheduleService ss = ScheduleService();
  final UserService us = UserService();

  Future<List<ScheduleManager>> fetchSchedulesByCafeId(int cafeId) async {
    return await ss.fetchSchedulesByCafeId(cafeId);
  }

  Future<int> getCafeId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId') ?? 3;
    UserModel? user = await us.getProfileDetails(userId);
    return user?.cafeID ?? -1;
  }
}
