import 'package:get/get.dart';

import '../../repository/heart_repository.dart';

class DeleteHeartDetail {
  final HeartRepository repository = Get.put(HeartRepositoryImpl());

  Future<void> call(int params) {
    return repository.deleteHeartDetail(params);
  }
}
