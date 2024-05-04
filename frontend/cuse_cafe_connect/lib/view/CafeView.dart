import 'package:flutter/material.dart';
import 'package:cuse_cafe_connect/model/CafeModel.dart';
import 'package:cuse_cafe_connect/controller/CafeController.dart';
import 'package:cuse_cafe_connect/view/CafeStudentView.dart';

class CafeView extends StatefulWidget {
  @override
  _CafeViewState createState() => _CafeViewState();
}

class _CafeViewState extends State<CafeView> {
  CafeController cc = CafeController();
  bool _isLoading = true;
  List<CafeModel> _cafeList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      List<CafeModel> cafeList = await cc.fetchCafeModels();
      cafeList = cafeList
          .where((cafe) => cafe.cafeID != 0 && cafe.cafeID != 113)
          .toList();
      setState(() {
        _cafeList = cafeList;
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0.0), // Adjust padding
              child: ListView.builder(
                itemCount: _cafeList.length,
                itemBuilder: (context, index) {
                  CafeModel cafe = _cafeList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0), // Adjust vertical padding
                    child: Card(
                      color: Color(0xFFF76900),
                      child: SizedBox(
                        height: 100,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${cafe.cafeName}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(height: 10), // Add spacing
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CafeStudentView(
                                              cafeId: cafe.cafeID),
                                        ),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                    ),
                                    child: Text(
                                      'Tap to View Employees',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0, // Reduce text size
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
