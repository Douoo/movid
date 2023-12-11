import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class GetPopularTvsUseCase {
  final TvSeriesRepository series;

  GetPopularTvsUseCase({required this.series});

  Future<Either<Failure, List<TvSeries>>> call(int page) {
    return series.getPopularTvSeries(page);
  }
}
