import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/series/domain/entites/season.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class GetTvsSeasonsUseCase {
  final TvSeriesRepository series;
  GetTvsSeasonsUseCase({required this.series});
  Future<Either<Failure, Season>> call() {
    return series.getTvSeriesSeasons();
  }
}
