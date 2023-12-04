import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class GetRecommendedTvsUseCase {
  final TvSeriesRepository series;
  GetRecommendedTvsUseCase({required this.series});
  Future<Either<Failure, List<TvSeries>>> call(int id) {
    return series.getRecommendedTvSeries(id);
  }
}
