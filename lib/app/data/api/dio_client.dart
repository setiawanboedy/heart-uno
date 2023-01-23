import 'dart:io';

import 'package:dio/dio.dart';

import 'dio_interceptor.dart';

class DioClient {
  String baseUrl = "https://heart-uno.onrender.com";

  late Dio _dio;
  bool _isUnitTest = false;

  DioClient({bool isUnitTest = false}) {
    _isUnitTest = isUnitTest;

    try {} catch (_) {}
    _dio = _createDio();
    if (!_isUnitTest) _dio.interceptors.add(DioInterceptor());
  }
  Dio _createDio() => Dio(
        BaseOptions(
            baseUrl: baseUrl,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            receiveTimeout: 60000,
            connectTimeout: 60000,
            validateStatus: (int? status) {
              return status! > 0;
            }),
      );
  Dio get dio {
    if (_isUnitTest) {
      return _dio;
    } else {
      try {} catch (_) {}
    }
    _dio = _createDio();
    if (!_isUnitTest) _dio.interceptors.add(DioInterceptor());
    return _dio;
  }

  Future<Response> getRequest(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(url, queryParameters: queryParameters, options: Options(
        contentType: "image/png"
      ));
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> postRequest(
    String url, {
    required File file,
  }) async {
    try {
      var multipart = await MultipartFile.fromFile(file.path);
      MapEntry<String, MultipartFile> multi = MapEntry('csv', multipart);

      FormData formData = FormData();
      formData.files.add(multi);
      final response = await dio.post(url, data: formData);
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
