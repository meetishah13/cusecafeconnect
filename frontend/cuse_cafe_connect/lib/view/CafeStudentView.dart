import 'package:cuse_cafe_connect/controller/ScheduleController.dart';
import 'package:cuse_cafe_connect/model/ScheduleManager.dart';
import 'package:flutter/material.dart';

class CafeStudentView extends StatefulWidget {
  final int cafeId;

  CafeStudentView({required this.cafeId});

  @override
  _CafeStudentViewState createState() => _CafeStudentViewState();
}

class _CafeStudentViewState extends State<CafeStudentView> {
  ScheduleController sc = ScheduleController();
  bool _isLoading = true;
  List<ScheduleManager> _finalCafeSch = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final List<ScheduleManager> schedule =
          await sc.fetchSchedulesByCafeId(widget.cafeId);

      final Set<String> uniqueUsernames = {};
      List<ScheduleManager> finalCafeSch = [];
      for (ScheduleManager sm in schedule) {
        if ((sm.userName?.isNotEmpty ?? false)) {
          if (!uniqueUsernames.contains(sm.userName)) {
            uniqueUsernames.add((sm?.userName ?? ''));
            finalCafeSch.add(sm);
          }
        }
      }

      setState(() {
        _finalCafeSch = finalCafeSch;
        _isLoading = false;
      });
    } catch (e) {
      print('Error in view: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _finalCafeSch.isEmpty
              ? Center(
                  child: Text('No one took shift'),
                )
              : ListView.builder(
                  itemCount: _finalCafeSch.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Color(0xFFF76900),
                      elevation: 3,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _finalCafeSch[index].userName ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.email,color: Colors.white,),
                                SizedBox(width: 5),
                                Text(
                                  _finalCafeSch[index].emailId ?? '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.phone,color: Colors.white,),
                                SizedBox(width: 5),
                                Text(
                                  _finalCafeSch[index].phoneNo ?? '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(
                            _finalCafeSch[index].userName?[0] ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
