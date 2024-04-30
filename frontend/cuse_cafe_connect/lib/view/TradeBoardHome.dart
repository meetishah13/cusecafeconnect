import 'package:cuse_cafe_connect/controller/TradeBoardController.dart';
import 'package:cuse_cafe_connect/view/TradeBoardGeneralView.dart';
import 'package:cuse_cafe_connect/view/TradeBoardRequestedView.dart';
import 'package:flutter/material.dart';

class TradeBoardHome extends StatefulWidget {
  const TradeBoardHome({Key? key}) : super(key: key);

  @override
  State<TradeBoardHome> createState() => _TradeBoardHomeState();
}

class _TradeBoardHomeState extends State<TradeBoardHome> {
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
                    text: "General",
                  ),
                  Tab(
                    text: "Requested",
                  ),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: TradeBoardGeneralView(tbc),
            ),
            Center(
              child: TradeBoardRequestedView(tbc),
            ),
          ],
        ),
      ),
    );
  }
}