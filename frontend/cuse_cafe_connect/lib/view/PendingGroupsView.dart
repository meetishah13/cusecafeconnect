import 'package:flutter/material.dart';
import '../controller/stu_cafe_group_controller.dart';


class PendingGroupsView extends StatelessWidget {
  final StuCafeGroupController controller = StuCafeGroupController();

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
            appBar: AppBar(
              title: Text('Pending Groups'),
            ),
            body: ListView.builder(
              itemCount: pendingGroups.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(pendingGroups[index]['UserName'] ?? ''),
                  subtitle: Text(pendingGroups[index]['CafeName'] ?? ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          // Implement accept action
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          // Implement reject action
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
