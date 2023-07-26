import 'package:get/get.dart';
import 'local/sql_helper.dart';
import 'model/frequency_model.dart';
import 'model/heart_item_model.dart';
import 'model/image_model.dart';
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
  Future<FrequencyModel> getFrequecy(NoParams params);
  Future<OriginalModel> getOriginal(NoParams params);
  Future<ImageModel> getSpectrum(NoParams params);
  Future<ImageModel> getDeteksi(NoParams params);
  Future<ImageModel> getKoreksi(NoParams params);
  Future<int> saveHeartItem(HeartItemModel params);
  Future<List<Map<String, dynamic>>> getHeartItems();
  Future<Map<String, dynamic>> getHeartItem(int id);
  Future<void> deleteHeartItem(int id);

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
  Future<ImageModel> getSpectrum(NoParams params) async {
    try {
      final response = await _client.getRequest(ListApi.spectrumImage);
      final result = response.data;
      if (response.statusCode == 200) {
        return ImageModel.fromJson(result);
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
      final response = await _client.getRequest(ListApi.timedomain);

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
  Future<ImageModel> getDeteksi(NoParams params) async {
    try {
      final response = await _client.getRequest(ListApi.deteksiR);
      final result = response.data;
      if (response.statusCode == 200) {
        return ImageModel.fromJson(result);
      } else {
        throw ServerException(result.toString());
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
  
  @override
  Future<FrequencyModel> getFrequecy(NoParams params) async {
    try {
      final response = await _client.getRequest(ListApi.frequencydomain);

      if (response.statusCode == 200) {
        final result = FrequencyModel.fromJson(response.data);
        return result;
      } else {
        throw ServerException(response.statusMessage);
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
  
  @override
  Future<ImageModel> getKoreksi(NoParams params) async {
   try {
      final response = await _client.getRequest(ListApi.koreksiR);
      final result = response.data;
      if (response.statusCode == 200) {
        return ImageModel.fromJson(result);
      } else {
        throw ServerException(result.toString());
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
}
