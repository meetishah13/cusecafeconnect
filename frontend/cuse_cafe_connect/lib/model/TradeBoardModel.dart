import 'dart:convert';
import 'dart:io';

class TradeBoardModel {
  final int subId;
  final String cafeName;
  final String dropUserName;
  final String timeSlot;
  final String timeSlotDay;
  final DateTime dropDate;
  final String status;
  final String pickUpUserName;
  final String comments;

  TradeBoardModel({
    required this.subId,
    required this.cafeName,
    required this.dropUserName,
    required this.timeSlot,
    required this.timeSlotDay,
    required this.dropDate,
    required this.status,
    required this.pickUpUserName,
    required this.comments,
  });

  factory TradeBoardModel.fromJson(Map<String, dynamic> json) {
    return TradeBoardModel(
      subId: json['subId'],
      cafeName: json['cafeName'],
      dropUserName: json['dropUserName'],
      timeSlot: json['timeSlot'],
      timeSlotDay: json['timeSlotDay'],
      dropDate: DateTime.parse(json['dropDate']),
      status: json['status'],
      pickUpUserName: json['pickUpUserName'],
      comments: json['comments'],
    );
  }
}