import 'package:cuse_cafe_connect/controller/TradeBoardController.dart';
import 'package:cuse_cafe_connect/model/TradeBoardModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TradeBoardManagerPendingView extends StatefulWidget {
  final TradeBoardController tbc;

  TradeBoardManagerPendingView(this.tbc);

  @override
  _TradeBoardManagerPendingViewState createState() =>
      _TradeBoardManagerPendingViewState();
}

class _TradeBoardManagerPendingViewState
    extends State<TradeBoardManagerPendingView> {
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
      final List<TradeBoardModel> subBooks =
      await widget.tbc.fetchManagerSubBook(userId);
      List<TradeBoardModel> finalSubBook = [];
      for(TradeBoardModel tbm in subBooks){
        if(tbm.status == 'In Review'){
          finalSubBook.add(tbm);
        }
      }
      setState(() {
        _subBooks = finalSubBook;
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
        child: Text('No request available'),
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

    if (tradeBoard.status == 'In Review') {
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
              Text(
                'Pickup User: ${tradeBoard.pickUpUserName}',
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      print('Accept button clicked ' +
                          tradeBoard.subId.toString());
                      bool success = await widget.tbc
                          .updateSubStatus(tradeBoard.subId, 1, "");
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
                    child: Text('Accept'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('Reject button clicked ' +
                          tradeBoard.subId.toString());
                      // Show reject reason dialog
                      _showRejectReasonDialog(tradeBoard.subId);
                    },
                    child: Text('Reject'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  void _showRejectReasonDialog(int subId) {
    String rejectReason = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reject Reason'),
          content: TextField(
            onChanged: (value) {
              rejectReason = value;
            },
            decoration: InputDecoration(hintText: 'Enter reason for rejection'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Print the reject reason to the debug console
                print('Reject reason for subId $subId: $rejectReason');
                bool success =
                await widget.tbc.updateSubStatus(subId, 2, rejectReason);
                print(success.toString());
                Navigator.of(context).pop();
                _loadData();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}