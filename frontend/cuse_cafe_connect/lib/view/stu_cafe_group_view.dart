import 'dart:io';
import 'package:cuse_cafe_connect/view/add_shifts_view.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences package
import '../controller/stu_cafe_group_controller.dart';
import '../model/stu_cafe_group.dart';

class StuCafeGroupView extends StatefulWidget {
  @override
  _StuCafeGroupViewState createState() => _StuCafeGroupViewState();
}

class _StuCafeGroupViewState extends State<StuCafeGroupView> {
  final StuCafeGroupController _controller = StuCafeGroupController();

  @override
  void initState() {
    super.initState();
    _getCafes();
  }

  Future<void> _getCafes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Management'),
        //backgroundColor: Color(0xFFF76900),
        //foregroundColor: Color(0xFF040261),
      ),
      body: FutureBuilder<Map<String, List<StuCafeGroup>>>(
        future: _getUserIdAndFetchCafes(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            Map<String, List<StuCafeGroup>> data = snapshot.data!;
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: TabBar(
                  tabs: [
                    Tab(text: 'User Groups'),
                    Tab(text: 'Requested Groups'),
                    Tab(text: 'Join Groups'),
                  ],
                ),
                body: TabBarView(
                  children: [
                    // First Tab - Cafes by User
                    if (data.containsKey('cafesByUser'))
                      ListView.builder(
                        itemCount: data['cafesByUser']!.length,
                        itemBuilder: (context, index) {
                          StuCafeGroup cafe = data['cafesByUser']![index];
                          return GestureDetector(
                            onTap: () {
                              // Handle card click for 'Cafes by User'
                            },
                            child: _buildCafeCard(cafe),
                          );
                        },
                      ),
                    if (data.containsKey('requestedCafe'))
                      ListView.builder(
                        itemCount: data['requestedCafe']!.length,
                        itemBuilder: (context, index) {
                          StuCafeGroup cafe = data['requestedCafe']![index];
                          return GestureDetector(
                            onTap: () {
                              // Handle card click for 'Cafes by User'
                            },
                            child: _buildCafeCard(cafe),
                          );
                        },
                      ),
                    // Second Tab - Cafes Not Member
                    if (data.containsKey('cafesNotMember'))
                      ListView.builder(
                        itemCount: data['cafesNotMember']!.length,
                        itemBuilder: (context, index) {
                          StuCafeGroup cafe = data['cafesNotMember']![index];
                          return GestureDetector(
                            onTap: null,
                            behavior: HitTestBehavior.opaque,
                            child: _buildCafeCard(cafe),
                          );
                        },
                      ),

                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  Future<Map<String, List<StuCafeGroup>>> _getUserIdAndFetchCafes(
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = (prefs.getInt('userId') ?? 6348).toString();
    String deviceType = getDeviceType();
    return _controller.fetchCafes(deviceType, userId);
  }

  Widget _buildCafeCard(StuCafeGroup cafe) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  cafe.cafeName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF040261),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      cafe.latitude,
                      cafe.longitude,
                    ),
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId(cafe.cafeName),
                      position: LatLng(
                        cafe.latitude,
                        cafe.longitude,
                      ),
                    ),
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Supervisors: ${cafe.supervisorList.join(', ')}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF040261),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 10.0,
            right: 8.0,
            child: GestureDetector(
              onTap: cafe.isAccepted == 2
                  ? null // Disable tap if isAccepted is 2
                  : () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: AddShiftsView(cafeID: cafe.cafeID),
                    );
                  },
                ).then((value) {
                  if (value == true) {
                    // Reload the page if the dialog is closed with success status
                    setState(() {});
                  }
                });
              },
              child: cafe.isAccepted == 2
                  ? Icon(
                Icons.cancel,
                color: Colors.red,
              )
                  : Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFF040261),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  // Widget _buildCafeCard(StuCafeGroup cafe) {
  //   return Card(
  //     elevation: 4.0,
  //     margin: EdgeInsets.all(8.0),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //     ),
  //     child: Stack(
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(12.0),
  //               child: Text(
  //                 cafe.cafeName,
  //                 style: TextStyle(
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.bold,
  //                   color: Color(0xFF040261),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               height: 200,
  //               child: GoogleMap(
  //                 initialCameraPosition: CameraPosition(
  //                   target: LatLng(
  //                     cafe.latitude,
  //                     cafe.longitude,
  //                   ),
  //                   zoom: 15,
  //                 ),
  //                 markers: {
  //                   Marker(
  //                     markerId: MarkerId(cafe.cafeName),
  //                     position: LatLng(
  //                       cafe.latitude,
  //                       cafe.longitude,
  //                     ),
  //                   ),
  //                 },
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(12.0),
  //               child: Text(
  //                 'Supervisors: ${cafe.supervisorList.join(', ')}',
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   color: Color(0xFF040261),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         Positioned(
  //           top: 10.0,
  //           right: 8.0,
  //           child: GestureDetector(
  //             onTap: () {
  //               showDialog(
  //                 context: context,
  //                 builder: (context) {
  //                   return Dialog(
  //                     child: AddShiftsView(cafeID: cafe.cafeID),
  //                   );
  //                 },
  //               ).then((value) {
  //                 if (value == true) {
  //                   // Reload the page if the dialog is closed with success status
  //                   setState(() {});
  //                 }
  //               });
  //             },
  //             child: Container(
  //               padding: EdgeInsets.all(8.0),
  //               decoration: BoxDecoration(
  //                 color: Color(0xFF040261),
  //                 borderRadius: BorderRadius.circular(5.0),
  //               ),
  //               child: Text(
  //                 'Add',
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  String getDeviceType() {
    if (Platform.isIOS) {
      return 'ios';
    } else if (Platform.isAndroid) {
      return 'android';
    } else {
      return 'unknown';
    }
  }
}
