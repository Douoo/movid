import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';

import '../entites/media_image.dart';
import '../entites/season_episode.dart';
import '../entites/series.dart';
import '../entites/series_detail.dart';


abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getOnAirTv(int page);
  Future<Either<Failure, List<Tv>>> getPopularTv(int page);
  Future<Either<Failure, List<Tv>>> getTopRatedTv(int page);
  Future<Either<Failure, TvDetail>> getDetailTv(int id);
  Future<Either<Failure, List<Tv>>> getRecommendedTv(int id);
  Future<Either<Failure, List<SeasonEpisode>>> getTvSeasonEpisodes(
      int id, int seasonNumber);
  Future<Either<Failure, List<Tv>>> searchTv(String data, int page);
  Future<Either<Failure, MediaImage>> getTvImages(int id);

  Future<bool> isAddedToWatchList(int id);
  Future<Either<Failure, List<Tv>>> getWatchListTv();
  Future<Either<Failure, bool>> addTvToWatchList(TvDetail tv);
  Future<Either<Failure, bool>> removeWatchListTv(TvDetail tv);
}
