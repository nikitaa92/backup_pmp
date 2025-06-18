import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:latihan_bloc_ti4ma/core/api_client.dart';
import 'package:latihan_bloc_ti4ma/models/table_resto_model.dart';
import 'package:latihan_bloc_ti4ma/response/table_resto_create_response.dart';
import 'package:latihan_bloc_ti4ma/param/table_resto_param.dart';


class TableRestoRepository extends ApiClient {
  Future<List<TableRestoModel>> getTableRestos() async {
    try {
      var response = await dio.get('table_resto');
      debugPrint('Table Resto GET ALL : ${response.data}');
      List list = response.data;
      List<TableRestoModel> listTableResto =
      list.map((element) => TableRestoModel.fromJson(element)).toList();
      return listTableResto;
    } on DioException catch (e) {
      throw Exception(e);
      //debugPrint(e.toString());
    }
  }

  Future<TableRestoCreateResponse> addTableResto(
      TableRestoParam tableRestoParam,
      ) async {
    try {
      //Options _options = Options(headers: {'Authorization': 'Token ...',},);
      var response = await dio.post(
        'table_resto',
        //options: _options,
        data: tableRestoParam.toJson(),
      );
      debugPrint('TableResto POST : ${response.data}');
      return TableRestoCreateResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}