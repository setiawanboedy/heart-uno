import 'dart:io';

import 'package:dio/dio.dart';

import 'dio_interceptor.dart';

class DioClient {
  String baseUrl = "https://momenkuy.herokuapp.com";

  String? _auth;
  late Dio _dio;

  Dio _createDio() => Dio(
        BaseOptions(
            baseUrl: baseUrl,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              if (_auth != null) ...{'Authorization': "Bearer $_auth"}
            },
            receiveTimeout: 60000,
            connectTimeout: 60000,
            validateStatus: (int? status) {
              return status! > 0;
            }),
      );
  Dio get dio {
    _dio = _createDio();
    _dio.interceptors.add(DioInterceptor());
    return _dio;
  }

  Future<Response> getRequest(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(url, queryParameters: queryParameters);
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> postRequest(
    String url, {
    File? file,
  }) async {
    try {
      var len = await file?.length();
      final response = await dio.post(
        url,
        data: file?.openRead(),
        options: Options(
          headers: {Headers.contentLengthHeader: len},
        ),
      );
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
