import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

import '../../entites/season_episode.dart';

class GetTvsSeasonsUseCase {
  final TvRepository tv;
  GetTvsSeasonsUseCase({required this.tv});
  Future<Either<Failure, List<SeasonEpisode>>> call(int id, int seasonNumber) {
    return tv.getTvSeasonEpisodes(id, seasonNumber);
  }
}
