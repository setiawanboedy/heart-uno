import 'package:get/get.dart';
import 'package:heart_usb/core/usecase/usecase.dart';

import '../../../core/error/exceptions.dart';
import '../api/dio_client.dart';
import '../api/list_api.dart';
import '../domain/usecase/post_csv.dart';
import 'model/heart_analysis_response.dart';

abstract class HeartDatasource {
  Future<HeartAnalysisResponse> uploadCSV(HeartParams params);
  Future<String> getOriginal(NoParams params);
}

class HeartDatasourceImpl implements HeartDatasource {
  final DioClient _client = Get.put(DioClient());

  @override
  Future<HeartAnalysisResponse> uploadCSV(HeartParams params) async {
    try {
      final response = await _client.postRequest(
        ListApi.uploadCsv,
        file: params.toJson(),
      );
      final result = HeartAnalysisResponse.fromJson(response.data);
      if (response.statusCode == 200) {
        return result;
      } else {
        throw ServerException(result.toString());
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<String> getOriginal(NoParams params) async {
    try {
      final response = await _client.getRequest(ListApi.originalImage);
      final result = response.data;
      if (response.statusCode == 200) {
        return result;
      } else {
        throw ServerException(result.toString());
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
}
