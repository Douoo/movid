import 'package:movid/core/errors/failure.dart';


import 'package:dartz/dartz.dart';

import '../../entites/series.dart';
import '../../repository/series_repository.dart';

class GetOnAirTvsUseCase {
  final TvRepository tv;
  GetOnAirTvsUseCase({required this.tv});
  Future<Either<Failure, List<Tv>>> call(int page) {
    return tv.getOnAirTv(page);
  }
}
