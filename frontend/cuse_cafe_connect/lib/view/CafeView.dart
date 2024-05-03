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
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0.0), // Add padding
              child: ListView.builder(
                itemCount: _cafeList.length,
                itemBuilder: (context, index) {
                  CafeModel cafe = _cafeList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CafeStudentView(cafeId: cafe.cafeID),
                        ),
                      );
                    },
                    child: Card(
                      color: Color(0xFFF76900),
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
                          ],
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
