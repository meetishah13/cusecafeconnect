enum ScheduleType { normal, pickup, drop }

class Schedule {
  final int scheduleId;
  final int timeSlotId;
  final int cafeId;
  final String timeSlot;
  final String timeSlotDay; // Handle as a String for day name or specific date
  final String cafeName;
  final ScheduleType type;
  final String? dropDate;

  Schedule({
    required this.scheduleId,
    required this.timeSlotId,
    required this.cafeId,
    required this.timeSlot,
    required this.timeSlotDay,
    required this.cafeName,
    this.type = ScheduleType.normal,
    this.dropDate, // Now it's an optional parameter
  });

  // Factory constructor for creating a Schedule from JSON data
  factory Schedule.fromJson(Map<String, dynamic> json,
      {ScheduleType type = ScheduleType.normal, String? dropDate}) {
    return Schedule(
      scheduleId: json['scheduleId'],
      timeSlotId: json['timeSlotId'],
      cafeId: json['cafeId'],
      timeSlot: json['timeSlot'],
      timeSlotDay: type == ScheduleType.pickup
          ? dropDate ?? json['timeSlotDay']
          : type == ScheduleType.drop
              ? dropDate ?? json['timeSlotDay']
              : json['timeSlotDay'],
      cafeName: json['cafeName'],
      type: type,
      dropDate: dropDate,
    );
  }
}
