// controller.dart
import '../model/time_slot_model.dart';

import '../model/stu_cafe_group.dart';
import '../service/api_service.dart';

class StuCafeGroupController {
  final APIService _service = APIService();

  Future<Map<String, List<StuCafeGroup>>> fetchCafes(
      String device, String userId) async {
    String url = "/stucafegroup/cafes/notmember/$userId";
    String localhost = (device == 'ios') ? 'localhost' : '10.0.2.2';

    return await _service.fetchCafes(localhost, url);
  }

  Future<List<TimeSlot>> fetchTimeSlotsByCafeId(String device, int cafeId) async {
    String url = "/timeslots/availableByCafe/";
    String localhost = (device == 'ios') ? 'localhost' : '10.0.2.2';

    return await _service.fetchTimeSlotsByCafeId(localhost, url, cafeId);
  }
  Future<bool> requestShift(String device, int userId, int cafeId, int timeSlotId, String comments) async {
    String url = "/stucafegroup/requestForShift/";
    if(comments.isEmpty) comments= " ";
    String localhost = (device == 'ios') ? 'localhost' : '10.0.2.2';
    return await _service.sendRequestForShift(localhost, url, userId, cafeId, timeSlotId,  comments);
  }

  //Deena Logic

  Future<List<Map<String, String>>> fetchPendingGroups(String device) async {
    String localhost = (device == 'ios') ? 'localhost' : '10.0.2.2';
    return await _service.fetchPendingGroups(localhost);
  }
  Future<bool> acceptGroup(String device,int groupId) async {
    String localhost = (device == 'ios') ? 'localhost' : '10.0.2.2';
    return await _service.acceptGroup(localhost,groupId);
  }
  Future<bool> rejectGroup(String device,int groupId) async {
    String localhost = (device == 'ios') ? 'localhost' : '10.0.2.2';
    return await _service.rejectGroup(localhost,groupId);
  }

}
