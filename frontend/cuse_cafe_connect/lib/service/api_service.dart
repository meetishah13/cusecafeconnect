// service.dart
import 'dart:convert';
import 'package:cuse_cafe_connect/model/stu_cafe_group.dart';
import 'package:cuse_cafe_connect/model/time_slot_model.dart';
import 'package:http/http.dart' as http;

class APIService {
  Future<Map<String, List<StuCafeGroup>>> fetchCafes(String device,String userId) async {
    final response = await http.get(Uri.parse('http://$device:8080/api$userId'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<StuCafeGroup> cafesByUser = [];
      List<StuCafeGroup> cafesNotMember = [];
      for (var cafeJson in jsonData['cafesByUser']) {
        cafesByUser.add(StuCafeGroup.fromJson(cafeJson));
      }
      for (var cafeJson in jsonData['cafesNotMember']) {
        cafesNotMember.add(StuCafeGroup.fromJson(cafeJson));
      }
      return {'cafesByUser': cafesByUser, 'cafesNotMember': cafesNotMember};
    } else {
      throw Exception('Failed to load cafes');
    }
  }

  Future<List<TimeSlot>> fetchTimeSlotsByCafeId(String device, String url,int cafeID) async  {
    final response = await http.get(Uri.parse('http://$device:8080/api$url$cafeID'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((timeSlotJson) => TimeSlot.fromJson(timeSlotJson)).toList();
    } else {
      throw Exception('Failed to load time slots');
    }
  }

}
