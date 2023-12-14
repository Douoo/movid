import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

import 'package:dartz/dartz.dart';

class GetOnAirTvsUseCase {
  final TvRepository tv;
  GetOnAirTvsUseCase({required this.tv});
  Future<Either<Failure, List<Tv>>> call(int page) {
    return tv.getOnAirTv(page);
  }
}
