import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class GetDetailTvsUseCase {
  final TvSeriesRepository series;
  GetDetailTvsUseCase({required this.series});
  Future<Either<Failure, SeriesDetail>> call(int id) {
    return series.getDetailTvSeries(id);
  }
}
