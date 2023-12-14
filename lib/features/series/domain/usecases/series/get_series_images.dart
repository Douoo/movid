import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/series/data/model/media_image_model.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class GetTvImages {
  final TvRepository tv;
  GetTvImages(this.tv);

  Future<Either<Failure, MediaImageModel>> call(int movieId) {
    return tv.getTvImages(movieId);
  }
}
