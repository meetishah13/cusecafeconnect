class ScheduleManager {
  final String timeSlot;
  final String timeSlotDay;
  final String? userName;
  final String? phoneNo;
  final String? emailId;

  ScheduleManager({
    required this.timeSlot,
    required this.timeSlotDay,
    this.userName,
    this.phoneNo,
    this.emailId,
  });

  factory ScheduleManager.fromJson(Map<String, dynamic> json) {
    return ScheduleManager(
      timeSlot: json['timeSlot'],
      timeSlotDay: json['timeSlotDay'],
      userName: json['userName'],
      phoneNo: json['phoneNo'],
      emailId: json['emailId'],
    );
  }
}
