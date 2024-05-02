import 'package:flutter/material.dart';
import '../controller/stu_cafe_group_controller.dart';

class PendingGroupsView extends StatefulWidget {
  @override
  _PendingGroupsViewState createState() => _PendingGroupsViewState();
}

class _PendingGroupsViewState extends State<PendingGroupsView> {
  final StuCafeGroupController controller = StuCafeGroupController();

  Future<void> _reloadData() async {
    setState(() {}); // Refresh the UI by rebuilding the widget tree
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, String>>>(
      future: controller.fetchPendingGroups('ios'),
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, String>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Map<String, String>> pendingGroups = snapshot.data!;
          return Scaffold(

            body: RefreshIndicator(
              onRefresh: _reloadData, // Refresh callback
              child: ListView.builder(
                itemCount: pendingGroups.length,
                itemBuilder: (BuildContext context, int index) {
                  final int groupId = int.tryParse(pendingGroups[index]['StuCafeGroupID'] ?? '') ?? 0;
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        pendingGroups[index]['UserName'] ?? '',
                        style: TextStyle(
                          color: Color(0xFF040261),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        pendingGroups[index]['CafeName'] ?? '',
                        style: TextStyle(
                          color: Color(0xFF040261),
                          fontSize: 16.0,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.check_circle, color: Colors.green, size: 32.0),
                            onPressed: () {
                              controller.acceptGroup('ios', groupId).then((success) {
                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Group accepted successfully'),
                                    ),
                                  );
                                  _reloadData(); // Reload data without navigating to a new screen
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Error accepting group'),
                                    ),
                                  );
                                }
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.cancel, color: Colors.red, size: 32.0),
                            onPressed: () {
                              controller.rejectGroup('ios', groupId).then((success) {
                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Group rejected successfully'),
                                    ),
                                  );
                                  _reloadData(); // Reload data without navigating to a new screen
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Error rejecting group'),
                                    ),
                                  );
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
