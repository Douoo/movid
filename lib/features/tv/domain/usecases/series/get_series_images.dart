import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';

import '../../entites/media_image.dart';
import '../../repository/series_repository.dart';

class GetTvImages {
  final TvRepository tv;
  GetTvImages(this.tv);

  Future<Either<Failure, MediaImage>> call(int movieId) {
    return tv.getTvImages(movieId);
  }
}
