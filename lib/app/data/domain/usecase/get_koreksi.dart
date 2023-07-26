import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:heart_usb/app/data/domain/entities/image_entity.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../repository/heart_repository.dart';


class GetKoreksi extends UseCase<ImageEntity, NoParams> {
  final HeartRepository repository = Get.put(HeartRepositoryImpl());
  @override
  Future<Either<Failure, ImageEntity>> call(NoParams params) {
    return repository.getKoreksi(params);
  }
}