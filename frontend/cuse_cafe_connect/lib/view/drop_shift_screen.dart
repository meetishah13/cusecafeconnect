import 'package:flutter/material.dart';
import 'package:cuse_cafe_connect/model/Shift.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DropShiftScreen extends StatefulWidget {
  final Schedule schedule;
  final DateTime selectedDay;
  final String userId;
  final int scheduleId;
  final int cafeId;
  final String date;
  final int subTypeId;
  final String timeSlot;
  final String cafeName;
  final int isAccepted;
  final Function(int, DateTime) onDropShiftSuccess; //drop check

  const DropShiftScreen({
    Key? key,
    required this.schedule,
    required this.selectedDay,
    required this.userId,
    required this.scheduleId,
    required this.cafeId,
    required this.date,
    required this.subTypeId,
    required this.timeSlot,
    required this.cafeName,
    required this.isAccepted,
    required this.onDropShiftSuccess, // drop check
  }) : super(key: key);

  @override
  State<DropShiftScreen> createState() => _DropShiftScreenState();
}

class _DropShiftScreenState extends State<DropShiftScreen> {
  final TextEditingController _commentsController = TextEditingController();
  bool _areYouSure = false;
  Future<void> _dropShift() async {
    final url = Uri.parse('http://localhost:8080/api/schedules/dropshift');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'scheduleId': widget.scheduleId,
      'subTypeId': widget.subTypeId,
      'userId': widget.userId,
      'cafeId': widget.cafeId,
      'dropDate': widget.selectedDay.toIso8601String(),
      'isAccepted': widget.isAccepted,
      'comments': _commentsController.text,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Show an alert dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Request Successful'),
            content: Text('Your Request has been sent to the Supervisor.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  /////////
                  widget.onDropShiftSuccess(widget.scheduleId,
                      widget.selectedDay); // Call the callback  drop shift
                  /////////
                  Navigator.pop(context); // Go back to the previous screen
                },
                child: Text('ok'),
              ),
            ],
          );
        },
      );
    } else {
      // Handle error response
      print('Drop shift failed: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropping Shift?'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/calendarimage.png', height: 130), // Image
            SizedBox(height: 100), // Gap
            Text('Cafe Name: ${widget.schedule.cafeName}'),
            Text('Time Slot: ${widget.schedule.timeSlot}'),
            SizedBox(height: 16.0), // Gap
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reason for dropping the shift :(',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8), // Add space between text and checkbox
              ],
            ),
            SizedBox(height: 8.0), // Gap between text and TextField
            TextField(
              controller: _commentsController,
              decoration: const InputDecoration(
                labelText: 'Enter your reason here..',
              ),
            ),
            SizedBox(height: 40), // Gap
            CheckboxListTile(
              title: const Text('Confirm your shift drop'),
              value: _areYouSure,
              onChanged: (value) {
                setState(() {
                  _areYouSure = value!;
                });
              },
            ),
            SizedBox(height: 20),
            Container(
              color: Colors.orange,
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'NOTE: This does not immediately drop the shift. A designated supervisor has to accept the request for this submission. The shift will be updated accordingly.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0, // Adjust the font size as needed
                  ),
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: _areYouSure ? _dropShift : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Submit Request'),
            ),
          ],
        ),
      ),
    );
  }
}
