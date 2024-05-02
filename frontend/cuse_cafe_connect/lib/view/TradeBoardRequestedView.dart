import 'package:cuse_cafe_connect/controller/TradeBoardController.dart';
import 'package:cuse_cafe_connect/model/TradeBoardModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TradeBoardRequestedView extends StatefulWidget {
  final TradeBoardController tbc;

  TradeBoardRequestedView(this.tbc);

  @override
  _TradeBoardRequestedViewState createState() =>
      _TradeBoardRequestedViewState();
}

class _TradeBoardRequestedViewState extends State<TradeBoardRequestedView> {
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
          await widget.tbc.fetchRequestedSubBooks(userId);
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
        child: Text('No requested shifts'),
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

    // Define variables for icons and status color
    IconData statusIcon;
    Color statusColor;

    // Set icons and colors based on status
    switch (tradeBoard.status) {
      case 'Accepted':
        statusIcon = Icons.check_circle;
        statusColor = Colors.green;
        break;
      case 'Rejected':
        statusIcon = Icons.cancel;
        statusColor = Colors.red;
        break;
      case 'In Review':
        statusIcon = Icons.hourglass_empty;
        statusColor = Colors.yellow;
        break;
      default:
        statusIcon = Icons.help_outline;
        statusColor = Colors.grey;
    }

    return Card(
      color: Color(0xFFF76900),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              statusIcon,
              color: statusColor,
            ),
            SizedBox(height: 8.0),
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
              'Shift Time: ${tradeBoard.timeSlot}',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8.0),
            Text(
              'Date: $formattedDate (${tradeBoard.timeSlotDay})',
              style: TextStyle(color: Colors.white),
            ),
            if (tradeBoard.comments != "") ...[
              SizedBox(height: 8.0),
              Text(
                'Reason: ${tradeBoard.comments}',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
