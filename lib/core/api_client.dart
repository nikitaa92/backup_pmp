import 'package:dio/dio.dart';

abstract class ApiClient{
  final Dio dio = Dio();

  ApiClient(){
    dio.options.headers['content-type'] = 'application/json';
    dio.options.baseUrl = 'http://10.0.2.2:8000/api/';
    // dio.options.baseUrl = 'http://10.18.2.228:8000/api/';
  }
//Dio get _dio => dio;
}