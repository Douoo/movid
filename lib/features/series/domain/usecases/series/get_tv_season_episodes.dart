import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';

import '../../entites/season_episode.dart';
import '../../repository/series_repository.dart';


class GetTvSeasonEpisodes {
  final TvRepository series;
  GetTvSeasonEpisodes({required this.series});
  Future<Either<Failure, List<SeasonEpisode>>> call(int id, int seasonNumber) {
    return series.getTvSeasonEpisodes(id, seasonNumber);
  }
}
