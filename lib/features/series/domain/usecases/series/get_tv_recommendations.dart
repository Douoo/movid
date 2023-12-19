import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';

import '../../entites/series.dart';
import '../../repository/series_repository.dart';


class GetRecommendedTvsUseCase {
  final TvRepository tv;
  GetRecommendedTvsUseCase({required this.tv});
  Future<Either<Failure, List<Tv>>> call(int id) {
    return tv.getRecommendedTv(id);
  }
}
