import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/exception.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/core/network/network_connection.dart';
import 'package:movid/features/series/data/data_sources/tv_series_remote_data_source_impl.dart';
import 'package:movid/features/series/data/model/media_image_model.dart';
import 'package:movid/features/series/domain/entites/season.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class TvSeriesRepositoryImpl implements TvSeriesRepository {
  final TvSeriesRemoteDataSource remoteDataSource;
  final NetworkConnection connection;

  TvSeriesRepositoryImpl(
      {required this.remoteDataSource, required this.connection});

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
  Future<bool> addSeriesToWatchList(TvSeries series) {
    return remoteDataSource.addSeriesToWatchList(series);
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getWatchListTvSeries() {
    // TODO: implement getWatchListTvSeries
    throw UnimplementedError();
  }

  @override
  Future<bool> removeWatchListSeries(TvSeries series) {
    // TODO: implement removeWatchListSeries
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, SeriesDetail>> getDetailTvSeries(int id) {
    return _remoteOperation(() => remoteDataSource.getDetailTvSeries(id));
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getOnAirTvSeries(int page) async {
    return await _remoteOperation(
        () => remoteDataSource.getOnAirTvSeries(page));
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries() async {
    return await _remoteOperation(() => remoteDataSource.getPopularTvSeries());
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getRecommendedTvSeries(int id) {
    // TODO: implement getRecommendedTvSeries
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries() async {
    return await _remoteOperation(() => remoteDataSource.getTopRatedTvSeries());
  }

  @override
  Future<Either<Failure, Season>> getTvSeriesSeasons() {
    // TODO: implement getTvSeriesSeasons
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String data) {
    // TODO: implement searchTvSeries
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, MediaImageModel>> getSeriesImages(int id) async {
    return await _remoteOperation(() => remoteDataSource.getSeriesImages(id));
  }
}
