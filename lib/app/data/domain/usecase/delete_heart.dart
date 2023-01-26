import 'package:get/get.dart';

import '../../repository/heart_repository.dart';

class DeleteHeart {
  final HeartRepository repository = Get.put(HeartRepositoryImpl());

  Future<void> call(int params) {
    return repository.deleteHeartItem(params);
  }
}
