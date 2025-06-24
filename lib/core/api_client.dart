import 'package:dio/dio.dart';

abstract class ApiClient {
  final Dio _dio = Dio();

  ApiClient() {
    _dio.options.headers['content-type'] = 'application/json';
    _dio.options.baseUrl = 'http://10.180.3.129:8000/api/';
    // _dio.options.baseUrl = 'http://10.0.2.2:8000/api/';
  }

  Dio get dio => _dio;
}
