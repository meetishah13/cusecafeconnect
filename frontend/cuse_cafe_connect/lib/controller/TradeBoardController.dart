import 'dart:convert';
import 'dart:io';

import 'package:cuse_cafe_connect/model/TradeBoardModel.dart';
import 'package:cuse_cafe_connect/service/TradeBoardService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TradeBoardController {
  final TradeBoardService tbs = TradeBoardService();

  Future<List<TradeBoardModel>> fetchSubBooks(int userId) async {
    return await tbs.fetchSubBooks(userId);
  }

  Future<List<TradeBoardModel>> fetchRequestedSubBooks(int userId) async {
    return await tbs.fetchRequestedSubBooks(userId);
  }

  Future<List<TradeBoardModel>> fetchManagerSubBook(int userId) async {
    return await tbs.fetchManagerSubBook(userId);
  }

  Future<bool> requestForSub(int subId, int userId) async{
    return tbs.requestForSub(subId, userId);
  }

  Future<bool> updateSubStatus(int subId, int status, String message) async{
    return tbs.updateSubStatus(subId, status, message);
  }

  Future<int> getUserIdFromCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId') ?? 6348;
    return userId;
  }


}