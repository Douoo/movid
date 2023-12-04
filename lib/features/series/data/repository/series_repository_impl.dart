import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/core/network/network_connection.dart';
import 'package:movid/features/series/data/data_sources/remote/remote_data_source_impl.dart';
import 'package:movid/features/series/data/model/media_image_model.dart';
import 'package:movid/features/series/domain/entites/season.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class SeriesRepositoryImpl implements TvSeriesRepository {
  final TvSeriesRemoteDataSource remoteDataSource;
  final NetworkConnection connection;

  SeriesRepositoryImpl(
      {required this.remoteDataSource, required this.connection});

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
    // TODO: implement getDetailTvSeries
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getOnAirTvSeries() {
    // TODO: implement getOAirTvSeries
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries() {
    // TODO: implement getPopularTvSeries
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getRecommendedTvSeries(int id) {
    // TODO: implement getRecommendedTvSeries
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries() {
    // TODO: implement getTopRatedTvSeries
    throw UnimplementedError();
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
  Future<Either<Failure, MediaImageModel>> getSeriesImages(int id) {
    // TODO: implement getSeriesImages
    throw UnimplementedError();
  }
}
