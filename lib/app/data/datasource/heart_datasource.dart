import 'package:get/get.dart';
import 'package:heart_usb/app/data/datasource/model/detail_model.dart';
import 'local/sql_helper.dart';
import 'model/heart_item_model.dart';
import 'model/original_model.dart';
import '../../../core/usecase/usecase.dart';

import '../../../core/error/exceptions.dart';
import '../api/dio_client.dart';
import '../api/list_api.dart';
import '../domain/usecase/post_csv.dart';
import 'model/heart_analysis_model.dart';

abstract class HeartDatasource {
  Future<String> uploadCSV(HeartParams params);
  Future<HeartAnalysisModel> getAnalysis(NoParams params);
  Future<OriginalModel> getOriginal(NoParams params);
  Future<String> getSpectrum(NoParams params);
  Future<int> saveHeartItem(HeartItemModel params);
  Future<List<Map<String, dynamic>>> getHeartItems();
  Future<Map<String, dynamic>> getHeartItem(int id);
  Future<void> deleteHeartItem(int id);

  // detail
  Future<int> saveHeartDetail(DetailModel analis);
  Future<Map<String, dynamic>?> getHeartDetail(int id);
  Future<void> deleteHeartDetail(int id);
}

class HeartDatasourceImpl implements HeartDatasource {
  final DioClient _client = Get.put(DioClient());

  @override
  Future<String> uploadCSV(HeartParams params) async {
    try {
      final response = await _client.postRequest(
        ListApi.uploadCsv,
        file: params.toJson(),
      );

      if (response.statusCode == 200) {
        const result = "success";
        return result;
      } else {
        throw ServerException(response.statusMessage);
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<OriginalModel> getOriginal(NoParams params) async {
    try {
      final response = await _client.getRequest(ListApi.originalImage);
      final result = response.data;
      if (response.statusCode == 200) {
        return OriginalModel.fromJson(result);
      } else {
        throw ServerException(result.toString());
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<String> getSpectrum(NoParams params) async {
    try {
      final response = await _client.getRequest(ListApi.spectrumImage);
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

  @override
  Future<HeartAnalysisModel> getAnalysis(NoParams params) async {
    try {
      final response = await _client.getRequest(ListApi.data);

      if (response.statusCode == 200) {
        final result = HeartAnalysisModel.fromJson(response.data);
        return result;
      } else {
        throw ServerException(response.statusMessage);
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<void> deleteHeartItem(int id) async {
    try {
      await SQLHelper.deleteHeartItem(id);
    } on LocalException catch (e) {
      throw LocalException(e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> getHeartItem(int id) async {
    try {
      final response = await SQLHelper.getHeartItem(id);
      return response.first;
    } on LocalException catch (e) {
      throw LocalException(e.message);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getHeartItems() async {
    try {
      final response = await SQLHelper.getHeartItems();
      return response;
    } on LocalException catch (e) {
      throw LocalException(e.message);
    }
  }

  @override
  Future<int> saveHeartItem(HeartItemModel params) async {
    try {
      final response = await SQLHelper.saveHeart(params);
      return response;
    } on LocalException catch (e) {
      throw LocalException(e.message);
    }
  }

  @override
  Future<int> saveHeartDetail(DetailModel analis) async {
    try {
      final response = await SQLHelper.saveHeartDetail(analis);
      return response;
    } on LocalException catch (e) {
      throw LocalException(e.message);
    }
  }

  @override
  Future<void> deleteHeartDetail(int id) async {
    try {
      await SQLHelper.deleteHeartDetail(id);
    } on LocalException catch (e) {
      throw LocalException(e.message);
    }
  }

  @override
  Future<Map<String, dynamic>?> getHeartDetail(int id) async {
    try {
      final response = await SQLHelper.getHeartDetail(id);
      
      return response.firstWhereOrNull((element) => element.isNotEmpty);
    } on LocalException catch (e) {
   
      throw LocalException(e.message);
    }
  }
}
