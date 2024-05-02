import 'dart:io';
import 'package:cuse_cafe_connect/view/add_shifts_view.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences package
import '../controller/stu_cafe_group_controller.dart';
import '../model/stu_cafe_group.dart';
import 'GoogleReviewsScreen.dart';

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
                    Tab(text: 'Own'),
                    Tab(text: 'Requested'),
                    Tab(text: 'Join'),
                  ],
                ),
                body: TabBarView(
                  children: [
                    if (data.containsKey('cafesByUser'))
                      ListView.builder(
                        itemCount: data['cafesByUser']!.length,
                        itemBuilder: (context, index) {
                          StuCafeGroup cafe = data['cafesByUser']![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GoogleReviewsScreen(
                                    cafeName: cafe.cafeName,
                                    cafeLat: cafe.latitude,
                                    cafeLong: cafe.longitude,
                                  ),
                                ),
                              );
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GoogleReviewsScreen(
                                    cafeName: cafe.cafeName,
                                    cafeLat: cafe.latitude,
                                    cafeLong: cafe.longitude,
                                  ),
                                ),
                              );
                            },
                            child: _buildCafeCard(cafe),
                          );
                        },
                      ),
                    if (data.containsKey('cafesNotMember'))
                      ListView.builder(
                        itemCount: data['cafesNotMember']!.length,
                        itemBuilder: (context, index) {
                          StuCafeGroup cafe = data['cafesNotMember']![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GoogleReviewsScreen(
                                    cafeName: cafe.cafeName,
                                    cafeLat: cafe.latitude,
                                    cafeLong: cafe.longitude,
                                  ),
                                ),
                              );
                            },
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
            right: 65.0, // Adjust the left position as needed
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GoogleReviewsScreen(
                      cafeName: cafe.cafeName,
                      cafeLat: cafe.latitude,
                      cafeLong: cafe.longitude,
                    ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xF76900), // Change the color as needed
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  'Reviews', // Change the text as needed
                  style: TextStyle(
                    color: Color(0xFFF76900),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
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