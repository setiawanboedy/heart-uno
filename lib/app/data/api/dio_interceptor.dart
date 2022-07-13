import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../modules/utils/common.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String headerMessage = '';
    options.headers.forEach((key, value) {
      headerMessage += '$key: $value';
    });
    try {
      options.queryParameters.forEach((key, value) {
        debugPrint('$key: $value');
      });
    } catch (_) {}

    // try {
    //   const JsonEncoder encoder = JsonEncoder.withIndent(' ');
    //   final String prettyJson = encoder.convert(options.data);

    //   log.d(
    //     "REQUEST ► ︎ ${options.method.toUpperCase()}\n\n"
    //     "Headers:\n"
    //     "$headerMessage\n"
    //     "❖ QueryParameters : \n"
    //     "Body: $prettyJson",
    //   );
    // } catch (e) {
    //   log.e("Failed to extract json request $e");
    // }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log.e(
      "<-- ${err.message} ${err.response?.requestOptions != null ? (err.response!.requestOptions.baseUrl + err.response!.requestOptions.path) : 'URL'}\n\n"
      "${err.response != null ? err.response!.data : 'Unknown Error'}",
    );
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String headerMessage = '';
    response.headers.forEach((key, value) {
      headerMessage += '$key: $value';
    });

    const JsonEncoder encoder = JsonEncoder.withIndent(' ');
    final String prettyJson = encoder.convert(response.data);

    log.d(
      "◀ ︎RESPONSE ${response.statusCode} ${response.requestOptions.baseUrl + response.requestOptions.path}\n\n"
      "Headers:\n"
      "$headerMessage\n"
      "❖ Results : \n"
      "Response: $prettyJson",
    );

    super.onResponse(response, handler);
  }
}
