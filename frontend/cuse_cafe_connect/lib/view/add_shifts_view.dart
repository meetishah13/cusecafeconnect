import 'package:cuse_cafe_connect/service/api_service.dart';
import 'package:cuse_cafe_connect/controller/stu_cafe_group_controller.dart';
import 'package:cuse_cafe_connect/model/time_slot_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddShiftsView extends StatefulWidget {
  final int cafeID;

  AddShiftsView({required this.cafeID});

  @override
  _AddShiftsViewState createState() => _AddShiftsViewState();
}

class _AddShiftsViewState extends State<AddShiftsView> {
  late Future<List<TimeSlot>> _futureTimeSlots;
  late int _selectedShiftId;
  late TextEditingController _commentsController;
  late int userID;

  @override
  void initState() {
    super.initState();
    _loadData();
  }
  void _loadData(){
    _futureTimeSlots = StuCafeGroupController().fetchTimeSlotsByCafeId('ios', widget.cafeID);
    _selectedShiftId = 0; // Set initial value to null
    _commentsController = TextEditingController();

    // Get userId from SharedPreferences
    SharedPreferences.getInstance().then((prefs) {
      userID = (prefs.getInt('userId') ?? 6348);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: FutureBuilder<List<TimeSlot>>(
          future: _futureTimeSlots,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Select Available Shift:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<int>(
                    items: snapshot.data!.map((timeSlot) {
                      return DropdownMenuItem<int>(
                        value: timeSlot.timeSlotId,
                        child: Text(
                            ' ${timeSlot.timeSlotDay} - ${timeSlot.timeSlot} ',
                            style: TextStyle( fontSize: 11.0) // Handle overflow with ellipsis
                        ),
                      );
                    }).toList(),
                    onChanged: (int? selectedShiftId) {
                      _selectedShiftId = selectedShiftId ?? 0;
                    },
                    decoration: InputDecoration(
                      labelText: 'Select Shift',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _commentsController,
                    decoration: InputDecoration(
                      labelText: 'Comments (Optional)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      submitForm();
                    },
                    child: Text('Submit'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void submitForm() async {
    // Check if a shift is selected
    if (_selectedShiftId != 0) {
      bool success = await StuCafeGroupController().requestShift('ios', userID, widget.cafeID, _selectedShiftId, _commentsController.text);
      if (success) {
        // Shift request submitted successfully
        Navigator.pop(context, true); // Close the dialog with success status
        setState(() {
          _loadData();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Request Sent'),
            backgroundColor: Colors.blue,
          ),
        );
      } else {
        // Failed to submit shift request
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit shift request'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // No shift selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a shift'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}