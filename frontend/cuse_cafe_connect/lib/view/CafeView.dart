import 'package:cuse_cafe_connect/view/CafeStudentView.dart';
import 'package:flutter/material.dart';
import 'package:cuse_cafe_connect/model/CafeModel.dart';
import 'package:cuse_cafe_connect/controller/CafeController.dart';

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
      cafeList = cafeList.where((cafe) => cafe.cafeID != 0 && cafe.cafeID != 113).toList();
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
      appBar: AppBar(
        title: Text('Cafes'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _cafeList.length,
              itemBuilder: (context, index) {
                CafeModel cafe = _cafeList[index];
                return Card(
                  child: ListTile(
                    title: Text(cafe.cafeName),
                    onTap: () {
                      _navigateToCafeStudentView(cafe.cafeID);
                    },
                  ),
                );
              },
            ),
    );
  }

  void _navigateToCafeStudentView(int cafeId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CafeStudentView(cafeId: cafeId),
      ),
    );
  }
}