import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/series/data/model/media_image_model.dart';
import 'package:movid/features/series/domain/entites/season.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getOnAirTvSeries(int page);
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries(int page);
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries(int page);
  Future<Either<Failure, SeriesDetail>> getDetailTvSeries(int id);
  Future<Either<Failure, List<TvSeries>>> getRecommendedTvSeries(int id);
  Future<Either<Failure, Season>> getTvSeriesSeasons();
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String data, int page);
  Future<Either<Failure, MediaImageModel>> getSeriesImages(int id);

  Future<bool> isAddedToWatchList(int id);
  Future<Either<Failure, List<TvSeries>>> getWatchListTvSeries();
  Future<Either<Failure, bool>> addSeriesToWatchList(SeriesDetail series);
  Future<Either<Failure, bool>> removeWatchListSeries(SeriesDetail series);
}
