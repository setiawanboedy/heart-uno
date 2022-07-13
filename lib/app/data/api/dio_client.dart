import 'dart:io';

import 'package:dio/dio.dart';
import '../../modules/utils/common.dart';

import 'dio_interceptor.dart';

class DioClient {
  String baseUrl = "https://heart-uno.herokuapp.com/";

  late Dio _dio;

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
    required File file,
  }) async {
    try {
      String fileName = file.path.split('/').last;
      log.d("message: ${file.path}");
      FormData formData = FormData.fromMap(
        {
          "file": await MultipartFile.fromFile(file.path, filename: fileName),
        },
        ListFormat.multiCompatible,
      );
      final response = await dio.post(
        url,
        data: formData,
        options: Options(
          method: 'POST',
          responseType: ResponseType.plain,
        ),
      );
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
