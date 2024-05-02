
class PendingSchedule {
  final String userName;
  final String cafeName;
  final String timeSlot;
  final String timeSlotDay;
  final int scheduleId;

  PendingSchedule({
    required this.userName,
    required this.cafeName,
    required this.timeSlot,
    required this.timeSlotDay,
    required this.scheduleId,
  });

  factory PendingSchedule.fromJson(Map<String, dynamic> json) {
    return PendingSchedule(
      userName: json['userName'],
      cafeName: json['cafeName'],
      timeSlot: json['timeSlot'],
      timeSlotDay: json['timeSlotDay'],
      scheduleId: json['scheduleId'],
    );
  }
}
