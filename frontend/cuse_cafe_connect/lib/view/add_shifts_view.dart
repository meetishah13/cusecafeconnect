import 'package:cuse_cafe_connect/service/api_service.dart';
import 'package:cuse_cafe_connect/controller/stu_cafe_group_controller.dart';
import 'package:cuse_cafe_connect/model/time_slot_model.dart';
import 'package:flutter/material.dart';

class AddShiftsView extends StatefulWidget {
  final int cafeID;

  AddShiftsView({required this.cafeID});

  @override
  _AddShiftsViewState createState() => _AddShiftsViewState();
}

class _AddShiftsViewState extends State<AddShiftsView> {
  late Future<List<TimeSlot>> _futureTimeSlots;

  @override
  void initState() {
    super.initState();
    _futureTimeSlots = StuCafeGroupController().fetchTimeSlotsByCafeId('ios', widget.cafeID);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        // padding: EdgeInsets.all(5.0),
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
                        // Handle selected shift
                      },
                      decoration: InputDecoration(
                        labelText: 'Select Shift',
                        border: OutlineInputBorder(),
                      ),
                  ),

                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Comments (Optional)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle form submission
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
}
