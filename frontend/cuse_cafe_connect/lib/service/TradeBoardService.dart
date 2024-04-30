import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cuse_cafe_connect/model/TradeBoardModel.dart';

class TradeBoardService {
  Future<List<TradeBoardModel>> fetchSubBooks(int userId) async {
    String apiUrl = 'http://localhost:8080/api/subBooks/filter/$userId';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<TradeBoardModel> tradeBoardRes =
      data.map((json) => TradeBoardModel.fromJson(json)).toList();
      return tradeBoardRes;
    } else {
      print('Error: ${response.reasonPhrase}');
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<TradeBoardModel>> fetchManagerSubBook(int userId) async {
    String apiUrl =
        'http://localhost:8080/api/subBooks/$userId/getSubBookSchedule';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<TradeBoardModel> tradeBoardRes =
      data.map((json) => TradeBoardModel.fromJson(json)).toList();
      return tradeBoardRes;
    } else {
      print('Error: ${response.reasonPhrase}');
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<TradeBoardModel>> fetchRequestedSubBooks(int userId) async {
    String apiUrl =
        'http://localhost:8080/api/subBooks/getRequestedSub/$userId';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<TradeBoardModel> tradeBoardRes =
      data.map((json) => TradeBoardModel.fromJson(json)).toList();
      return tradeBoardRes;
    } else {
      print('Error: ${response.reasonPhrase}');
      throw Exception('Failed to fetch data');
    }
  }

  Future<bool> requestForSub(int subId, int userId) async {
    String apiUrl =
        'http://localhost:8080/api/subBooks/$subId/requestForSub/$userId';

    try {
      final response = await http.post(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        print('Request successful ' + response.body);
        return true;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> updateSubStatus(int subId, int status, String message) async {
    String apiUrl =
        'http://localhost:8080/api/subBooks/$subId/updateSubStatus/$status';
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final body = jsonEncode(message);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        print('Request successful ' + response.body);
        return true;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}