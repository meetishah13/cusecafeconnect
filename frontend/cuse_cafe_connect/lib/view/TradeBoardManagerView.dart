import 'package:cuse_cafe_connect/controller/TradeBoardController.dart';
import 'package:cuse_cafe_connect/model/TradeBoardModel.dart';
import 'package:cuse_cafe_connect/view/TradeBoardManagerCompletedView.dart';
import 'package:cuse_cafe_connect/view/TradeBoardManagerPendingView.dart';
import 'package:flutter/material.dart';

class TradeBoardManagerView extends StatefulWidget {
  final TradeBoardController tbc;

  TradeBoardManagerView(this.tbc);

  @override
  _TradeBoardManagerViewState createState() => _TradeBoardManagerViewState();
}

class _TradeBoardManagerViewState extends State<TradeBoardManagerView> {
  final TradeBoardController tbc = TradeBoardController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                tabs: [
                  Tab(
                    text: "Pending",
                  ),
                  Tab(
                    text: "Completed",
                  ),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: TradeBoardManagerPendingView(tbc),
            ),
            Center(
              child: TradeBoardManagerCompletedView(tbc),
            ),
          ],
        ),
      ),
    );
  }
}