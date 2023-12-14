import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class GetPopularTvsUseCase {
  final TvRepository tv;

  GetPopularTvsUseCase({required this.tv});

  Future<Either<Failure, List<Tv>>> call(int page) {
    return tv.getPopularTv(page);
  }
}
