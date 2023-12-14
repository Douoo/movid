import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/exception.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/core/network/network_connection.dart';
import 'package:movid/features/series/data/data_sources/local/tv_series_local_data_source.dart';
import 'package:movid/features/series/data/data_sources/tv_series_remote_data_source_impl.dart';
import 'package:movid/features/series/data/model/media_image_model.dart';
import 'package:movid/features/series/data/model/series_data.dart';
import 'package:movid/features/series/domain/entites/season.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class TvRepositoryImpl implements TvRepository {
  final TvRemoteDataSource remoteDataSource;
  final TvLocalDataSource localDataSource;
  final NetworkConnection connection;

  TvRepositoryImpl(
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
  Future<Either<Failure, bool>> addTvToWatchList(TvDetail tv) {
    return _remoteOperation(
        () => localDataSource.addTvToWatchList(TvData.copy(tv)));
  }

  @override
  Future<Either<Failure, List<Tv>>> getWatchListTv() {
    return _remoteOperation(() => localDataSource.getWatchListTv());
  }

  @override
  Future<Either<Failure, bool>> removeWatchListTv(TvDetail tv) {
    return _remoteOperation(() => localDataSource.removeWatchListTv(tv.id));
  }

  @override
  Future<Either<Failure, TvDetail>> getDetailTv(int id) async {
    return await _remoteOperation(() => remoteDataSource.getDetailTv(id));
  }

  @override
  Future<Either<Failure, List<Tv>>> getOnAirTv(int page) async {
    return await _remoteOperation(() => remoteDataSource.getOnAirTv(page));
  }

  @override
  Future<Either<Failure, List<Tv>>> getPopularTv(int page) async {
    return await _remoteOperation(() => remoteDataSource.getPopularTv(page));
  }

  @override
  Future<Either<Failure, List<Tv>>> getRecommendedTv(int id) async {
    return await _remoteOperation(() async {
      return await remoteDataSource.getRecommendedTv(id);
    });
  }

  @override
  Future<Either<Failure, List<Tv>>> getTopRatedTv(int page) async {
    return await _remoteOperation(() => remoteDataSource.getTopRatedTv(page));
  }

  @override
  Future<Either<Failure, List<SeasonEpisode>>> getTvSeasons(
      int id, int seasonNumber) async {
    return await _remoteOperation(
        () => remoteDataSource.getTvSeasons(id, seasonNumber));
  }

  @override
  Future<Either<Failure, List<Tv>>> searchTv(String data, int page) async {
    return await _remoteOperation(() => remoteDataSource.searchTv(data, page));
  }

  @override
  Future<Either<Failure, MediaImageModel>> getTvImages(int id) async {
    return await _remoteOperation(() => remoteDataSource.getTvImages(id));
  }

  @override
  Future<bool> isAddedToWatchList(int id) {
    return localDataSource.isAddedToWatchList(id);
  }
}
