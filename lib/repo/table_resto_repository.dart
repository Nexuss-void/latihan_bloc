import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:latihan_bloc_ti4malama/core/api_client.dart';
import 'package:latihan_bloc_ti4malama/models/table_resto_model.dart';
import 'package:latihan_bloc_ti4malama/param/tabel_resto_param.dart';
import 'package:latihan_bloc_ti4malama/response/tabel_resto_create_respon.dart';

class TableRestoRepository extends ApiClient {
  Future<List<TableRestoModel>> getTableRestos() async {
    try {
      var response = await dio.get('table_resto_list');
      debugPrint('Table Resto GET ALL:${response.data}');
      debugPrint(response.data.runtimeType.toString());
      List list = response.data;
      List<TableRestoModel> listTableResto =
          list.map((element) => TableRestoModel.fromJson(element)).toList();
      return listTableResto;
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<TabelRestoCreateResponse> addTableResto(
    TableRestoParam tableRestoParam,
  ) async {
    try {
      var response =
          await dio.post('table_resto', data: tableRestoParam.toJson());
      debugPrint('TabelResto POST: ${response.data}');
      return TabelRestoCreateResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<TabelRestoCreateResponse> upadteTableResto(
    TableRestoParam tableRestoParam,
  ) async {
    try {
      var response = await dio.patch('table_resto/${tableRestoParam.id}',
          data: tableRestoParam.toJsonUpdate());
      debugPrint('Table Resto UPDATE : ${response.data}');
      return TabelRestoCreateResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
