
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:heart_usb/app/data/domain/entities/frequency.dart';
import '../../repository/heart_repository.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';

class GetFrequency extends UseCase<Frequency, NoParams> {
  final HeartRepository repository = Get.put(HeartRepositoryImpl());

  @override
  Future<Either<Failure, Frequency>> call(NoParams params) {
    return repository.getFrequency(params);
  }
}
