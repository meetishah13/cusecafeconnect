class StuCafeGroup {
  final String cafeName;
  final int cafeID;
  final List<String> supervisorList;
  final double latitude;
  final double longitude;
  final int? isAccepted; // Nullable bool to handle missing values

  StuCafeGroup({
    required this.cafeName,
    required this.cafeID,
    required this.supervisorList,
    required this.latitude,
    required this.longitude,
    this.isAccepted, // Optional parameter
  });

  factory StuCafeGroup.fromJson(Map<String, dynamic> json) {
    return StuCafeGroup(
      cafeName: json['cafeName'] ?? "",
      cafeID: json['cafeID'],
      supervisorList: List<String>.from(json['supervisorList'] ?? []),
      latitude: double.parse(json['cafeLatitude'].toString().trim()),
      longitude: double.parse(json['cafeLongitude'].toString().trim()),
      isAccepted: json['isAccepted'] != null ? json['isAccepted'] as int : null, // Handling nullable value
    );
  }
}