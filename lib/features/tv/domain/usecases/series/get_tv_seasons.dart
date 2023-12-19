import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';

import '../../entites/season_episode.dart';
import '../../repository/series_repository.dart';

class GetTvsSeasonsUseCase {
  final TvRepository tv;
  GetTvsSeasonsUseCase({required this.tv});
  Future<Either<Failure, List<SeasonEpisode>>> call(int id, int seasonNumber) {
    return tv.getTvSeasonEpisodes(id, seasonNumber);
  }
}
