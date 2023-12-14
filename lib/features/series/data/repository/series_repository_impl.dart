import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/exception.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/core/network/network_connection.dart';
import 'package:movid/features/series/data/data_sources/tv_series_local_data_source.dart';
import 'package:movid/features/series/data/data_sources/tv_series_remote_data_source_impl.dart';
import 'package:movid/features/series/data/model/media_image_model.dart';
import 'package:movid/features/series/data/model/series_data.dart';
import 'package:movid/features/series/domain/entites/season_episode.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class TvSeriesRepositoryImpl implements TvSeriesRepository {
  final TvSeriesRemoteDataSource remoteDataSource;
  final TvSeriesLocalDataSource localDataSource;
  final NetworkConnection connection;

  TvSeriesRepositoryImpl(
      {required this.remoteDataSource,
      required this.connection,
      required this.localDataSource});

  Future<Either<Failure, T>> _remoteOperation<T>(
      Future<T> Function() operation) async {
    if (await connection.isAvailable) {
      try {
        final result = await operation();
        return Right(result);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> addSeriesToWatchList(SeriesDetail series) {
    return _remoteOperation(
        () => localDataSource.addSeriesToWatchList(SeriesData.copy(series)));
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getWatchListTvSeries() {
    return _remoteOperation(() => localDataSource.getWatchListTvSeries());
  }

  @override
  Future<Either<Failure, bool>> removeWatchListSeries(SeriesDetail series) {
    return _remoteOperation(
        () => localDataSource.removeWatchListSeries(series.id));
  }

  @override
  Future<Either<Failure, SeriesDetail>> getDetailTvSeries(int id) async {
    return await _remoteOperation(() => remoteDataSource.getDetailTvSeries(id));
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getOnAirTvSeries(int page) async {
    return await _remoteOperation(
        () => remoteDataSource.getOnAirTvSeries(page));
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries(int page) async {
    return await _remoteOperation(
        () => remoteDataSource.getPopularTvSeries(page));
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getRecommendedTvSeries(int id) async {
    return await _remoteOperation(() async {
      // print(await remoteDataSource.getRecommendedTvSeries(id));
      return await remoteDataSource.getRecommendedTvSeries(id);
    });
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries(int page) async {
    return await _remoteOperation(
        () => remoteDataSource.getTopRatedTvSeries(page));
  }

  @override
  Future<Either<Failure, List<SeasonEpisode>>> getTvSeasonEpisodes(
      int id, int seasonNumber) async {
    return await _remoteOperation(
        () => remoteDataSource.getTvSeasonEpisodes(id, seasonNumber));
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(
      String data, int page) {
    // TODO: implement searchTvSeries
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, MediaImageModel>> getSeriesImages(int id) async {
    return await _remoteOperation(() => remoteDataSource.getSeriesImages(id));
  }

  @override
  Future<bool> isAddedToWatchList(int id) {
    return localDataSource.isAddedToWatchList(id);
  }
}
