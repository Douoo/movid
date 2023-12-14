import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/series/domain/entites/season.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class GetTvsSeasonsUseCase {
  final TvRepository tv;
  GetTvsSeasonsUseCase({required this.tv});
  Future<Either<Failure, List<SeasonEpisode>>> call(int id, int seasonNumber) {
    return tv.getTvSeasons(id, seasonNumber);
  }
}
