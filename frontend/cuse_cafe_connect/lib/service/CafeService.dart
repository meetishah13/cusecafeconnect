import 'dart:convert';
import 'package:cuse_cafe_connect/model/CafeModel.dart';
import 'package:http/http.dart' as http;

class CafeService {
  Future<List<CafeModel>> fetchCafeModels() async {
    final response = await http.get(Uri.parse('http://localhost:8080/api/cafes'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<CafeModel> cafes = data.map((item) => CafeModel.fromJson(item)).toList();
      return cafes;
    } else {
      throw Exception('Failed to load cafes');
    }
  }
}