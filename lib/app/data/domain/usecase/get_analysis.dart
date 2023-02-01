
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import '../entities/heart.dart';
import '../../repository/heart_repository.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';

class GetAnalysis extends UseCase<Heart, NoParams> {
  final HeartRepository repository = Get.put(HeartRepositoryImpl());

  @override
  Future<Either<Failure, Heart>> call(NoParams params) {
    return repository.getAnalysis(params);
  }
}
