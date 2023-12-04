import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';
import 'package:dartz/dartz.dart';

class GetOnAirTvsUseCase {
  final TvSeriesRepository series;
  GetOnAirTvsUseCase({required this.series});
  Future<Either<Failure, List<TvSeries>>> call() {
    return series.getOnAirTvSeries();
  }
}
