import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:heart_usb/app/data/datasource/model/heart_item_model.dart';
import 'package:heart_usb/core/failure/failure.dart';
import 'package:heart_usb/core/usecase/usecase.dart';

import '../../repository/heart_repository.dart';

class GetHeart extends UseCase<HeartItemModel, int> {
  final HeartRepository repository = Get.put(HeartRepositoryImpl());

  @override
  Future<Either<Failure, HeartItemModel>> call(int params) {
    return repository.getHeartItem(params);
  }
}
