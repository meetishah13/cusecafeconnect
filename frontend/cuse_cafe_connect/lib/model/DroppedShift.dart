class DroppedShift {
  final int scheduleId;
  final DateTime selectedDay;

  DroppedShift({
    required this.scheduleId,
    required this.selectedDay,
  });

  //shred pref:
  factory DroppedShift.fromJson(Map<String, dynamic> json) {
    return DroppedShift(
      scheduleId: json['scheduleId'],
      selectedDay: DateTime.parse(json['selectedDay']),
    );
  }
}
