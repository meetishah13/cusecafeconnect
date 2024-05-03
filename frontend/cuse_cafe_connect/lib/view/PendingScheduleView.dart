import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../controller/ScheduleController.dart';
import '../model/PendingSchedule.dart';

class PendingScheduleView extends StatefulWidget {
  @override
  _PendingScheduleViewState createState() => _PendingScheduleViewState();
}

class _PendingScheduleViewState extends State<PendingScheduleView> {
  final ScheduleController controller = ScheduleController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PendingSchedule>>(
      future: controller.fetchPendingSchedules(),
      builder: (BuildContext context, AsyncSnapshot<List<PendingSchedule>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<PendingSchedule> pendingSchedules = snapshot.data!;
          return pendingSchedules.isEmpty
              ? Center(
                  child: Text('No pending request for schedules'),
                )
              : Scaffold(
                  body: ListView.builder(
                    itemCount: pendingSchedules.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(pendingSchedules[index].userName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Cafe Name: ${pendingSchedules[index].cafeName}'),
                              Text('Time Slot: ${pendingSchedules[index].timeSlot}'),
                              Text('Day: ${pendingSchedules[index].timeSlotDay}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.check_circle, color: Colors.green),
                                onPressed: () => _showCommentDialog(context, true, pendingSchedules[index].scheduleId),
                              ),
                              IconButton(
                                icon: Icon(Icons.cancel, color: Colors.red),
                                onPressed: () => _showCommentDialog(context, false, pendingSchedules[index].scheduleId),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
        }
      },
    );
  }

  void _showCommentDialog(BuildContext context, bool accept, int scheduleId) {
    String action = accept ? 'accept' : 'reject';
    TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$action Schedule'),
          content: TextField(
            controller: commentController,
            decoration: InputDecoration(labelText: 'Enter comment'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _performAction(context, accept, scheduleId, commentController.text);
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _performAction(BuildContext context, bool accept, int scheduleId, String comment) {
    if (accept) {
      controller.acceptSchedule(scheduleId, comment).then((success) {
        setState(() {}); // Reload the view
        Navigator.of(context).pop(); // Dismiss the dialog
        final message = success ? 'Schedule accepted successfully' : 'Error accepting schedule';
        final color = success ? Colors.green : Colors.red;
        _showSnackbar(context, message, color);
      });
    } else {
      controller.rejectSchedule(scheduleId, comment).then((success) {
        setState(() {}); // Reload the view
        Navigator.of(context).pop(); // Dismiss the dialog
        final message = success ? 'Schedule rejected successfully' : 'Error rejecting schedule';
        final color = success ? Colors.green : Colors.red;
        _showSnackbar(context, message, color);
      });
    }
  }

  void _showSnackbar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
