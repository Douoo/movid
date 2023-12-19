import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import '../entites/series.dart';
import '../repository/series_repository.dart';

class GetWatchListTvsUseCase {
  final TvRepository tv;
  GetWatchListTvsUseCase({required this.tv});
  Future<Either<Failure, List<Tv>>> call() {
    return tv.getWatchListTv();
  }
}
