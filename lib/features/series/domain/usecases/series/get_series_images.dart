import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/series/data/model/media_image_model.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class GetSeriesImages {
  final TvSeriesRepository series;
  GetSeriesImages(this.series);

  Future<Either<Failure, MediaImageModel>> call(int movieId) {
    return series.getSeriesImages(movieId);
  }
}
