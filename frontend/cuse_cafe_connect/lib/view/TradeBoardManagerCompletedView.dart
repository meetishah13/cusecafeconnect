import 'package:cuse_cafe_connect/controller/TradeBoardController.dart';
import 'package:cuse_cafe_connect/model/TradeBoardModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TradeBoardManagerCompletedView extends StatefulWidget {
  final TradeBoardController tbc;

  TradeBoardManagerCompletedView(this.tbc);

  @override
  _TradeBoardManagerCompletedViewState createState() =>
      _TradeBoardManagerCompletedViewState();
}

class _TradeBoardManagerCompletedViewState
    extends State<TradeBoardManagerCompletedView> {
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
      int userId = prefs.getInt('userId') ?? 3;
      final List<TradeBoardModel> subBooks =
          await widget.tbc.fetchManagerSubBook(userId);
      List<TradeBoardModel> finalSubBook = [];
      for (TradeBoardModel tbm in subBooks) {
        if (tbm.status != 'In Review') {
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

    IconData? iconData;
    Color? iconColor;

    if (tradeBoard.status == 'Accepted') {
      iconData = Icons.check_circle;
      iconColor = Colors.white;
    } else if (tradeBoard.status == 'Rejected') {
      iconData = Icons.cancel;
      iconColor = Colors.white;
    }

    return Card(
      color: Color(0xFFF76900),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Cafe Name: ${tradeBoard.cafeName}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Timing: ${tradeBoard.timeSlot}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Date: $formattedDate (${tradeBoard.timeSlotDay})',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Drop User: ${tradeBoard.dropUserName}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Pickup User: ${tradeBoard.pickUpUserName}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0),
            if (iconData != null && iconColor != null) ...[
              Icon(
                iconData,
                color: iconColor,
                size: 40,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
