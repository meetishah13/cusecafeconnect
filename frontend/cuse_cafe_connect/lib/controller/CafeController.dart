import 'package:cuse_cafe_connect/model/CafeModel.dart';
import 'package:cuse_cafe_connect/service/CafeService.dart';

class CafeController{
  final CafeService cs = CafeService();

  Future<List<CafeModel>> fetchCafeModels() async {
    return cs.fetchCafeModels();
  }
}