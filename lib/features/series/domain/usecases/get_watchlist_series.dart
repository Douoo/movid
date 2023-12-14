import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class GetWatchListTvsUseCase {
  final TvRepository tv;
  GetWatchListTvsUseCase({required this.tv});
  Future<Either<Failure, List<Tv>>> call() {
    return tv.getWatchListTv();
  }
}
