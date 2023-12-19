import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';

import '../../entites/series.dart';
import '../../repository/series_repository.dart';


class GetTopRatedTvsUseCase {
  final TvRepository tv;
  GetTopRatedTvsUseCase({required this.tv});
  Future<Either<Failure, List<Tv>>> call(int page) {
    return tv.getTopRatedTv(page);
  }
}
