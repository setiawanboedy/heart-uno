import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import '../../datasource/model/heart_item_model.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';

import '../../repository/heart_repository.dart';

class GetHearts extends UseCase<HeartListModel, NoParams> {
  final HeartRepository repository = Get.put(HeartRepositoryImpl());

  @override
  Future<Either<Failure, HeartListModel>> call(NoParams params) {
    return repository.getHeartItems();
  }
}
