import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class RemoveTvsFromWatchListUseCase {
  final TvSeriesRepository series;

  RemoveTvsFromWatchListUseCase({required this.series});

  Future<Either<Failure, bool>> call(SeriesDetail tvSeries) {
    return series.removeWatchListSeries(tvSeries);
  }
}
