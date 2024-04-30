import 'package:cuse_cafe_connect/controller/TradeBoardController.dart';
import 'package:cuse_cafe_connect/model/TradeBoardModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TradeBoardGeneralView extends StatefulWidget {
  final TradeBoardController tbc;

  TradeBoardGeneralView(this.tbc);

  @override
  _TradeBoardGeneralViewState createState() => _TradeBoardGeneralViewState();
}

class _TradeBoardGeneralViewState extends State<TradeBoardGeneralView> {
  bool _isLoading = true;
  List<TradeBoardModel> _subBooks = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt('userId') ?? 6348;
      final List<TradeBoardModel> subBooks = await widget.tbc.fetchSubBooks(userId);
      setState(() {
        _subBooks = subBooks;
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
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
          : _buildCards(),
    );
  }

  Widget _buildCards() {
    if (_subBooks.isEmpty) {
      return Center(
        child: Text('No shift are available'),
      );
    } else {
      return ListView.builder(
        itemCount: _subBooks.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: _buildCard(_subBooks[index]),
          );
        },
      );
    }
  }

  Widget _buildCard(TradeBoardModel tradeBoard) {
    String formattedDate =
        '${tradeBoard.dropDate.month}/${tradeBoard.dropDate.day}/${tradeBoard.dropDate.year}';

    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Cafe Name: ${tradeBoard.cafeName}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Timing: ${tradeBoard.timeSlot}',
            ),
            SizedBox(height: 8.0),
            Text(
              'Date: $formattedDate (${tradeBoard.timeSlotDay})',
            ),
            SizedBox(height: 8.0),
            Text(
              'Drop User: ${tradeBoard.dropUserName}',
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    int userId = await widget.tbc.getUserIdFromCache();
                    bool success =
                    await widget.tbc.requestForSub(tradeBoard.subId, userId);
                    if (success) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Success'),
                            content: Text('Request successfully done.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _loadData();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text(
                                'There was an error. Please try again later.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text('Request'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}