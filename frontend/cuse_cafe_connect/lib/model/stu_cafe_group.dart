// stu_cafe_group.dart
class StuCafeGroup {
  final String cafeName;
  final int cafeID;
  final List<String> supervisorList;
  final double latitude;
  final double longitude;

  StuCafeGroup({
    required this.cafeName,
    required this.cafeID,
    required this.supervisorList,
    required this.latitude,
    required this.longitude,
  });

  factory StuCafeGroup.fromJson(Map<String, dynamic> json) {
    return StuCafeGroup(
      cafeName: json['cafeName'] ?? "",
      cafeID: json['cafeID'],
      supervisorList: List<String>.from(json['supervisorList'] ?? []),
      latitude: double.parse(json['cafeLatitude'].toString().trim()),
      longitude: double.parse(json['cafeLongitude'].toString().trim()),
    );
  }
}
