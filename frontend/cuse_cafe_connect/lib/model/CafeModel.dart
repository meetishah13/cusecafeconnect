class CafeModel {
  final int cafeID;
  final String cafeName;
  final double? cafeLat;
  final double? cafeLong;

  CafeModel({
    required this.cafeID,
    required this.cafeName,
    this.cafeLat,
    this.cafeLong,
  });

  factory CafeModel.fromJson(Map<String, dynamic> json) {
    return CafeModel(
      cafeID: json['cafeID'],
      cafeName: json['cafeName'],
      cafeLat: json['cafeLat'] != null ? double.parse(json['cafeLat'].toString()) : null,
      cafeLong: json['cafeLong'] != null ? double.parse(json['cafeLong'].toString()) : null,
    );
  }
}
