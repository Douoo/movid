import 'package:movid/features/series/domain/entites/season.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class SeriesRepositoryImpl implements TvSeriesRepository {
  @override
  Future<bool> addSeriesToWatchList(TvSeries series) {
    // TODO: implement addSeriesToWatchList
    throw UnimplementedError();
  }

  @override
  Future<List<TvSeries>> getWatchListTvSeries() {
    // TODO: implement getWatchListTvSeries
    throw UnimplementedError();
  }

  @override
  Future<bool> removeWatchListSeries(TvSeries series) {
    // TODO: implement removeWatchListSeries
    throw UnimplementedError();
  }

  @override
  Future<List<TvSeries>> getDetailTvSeries(int id) {
    // TODO: implement getDetailTvSeries
    throw UnimplementedError();
  }

  @override
  Future<List<TvSeries>> getOnAirTvSeries() {
    // TODO: implement getOAirTvSeries
    throw UnimplementedError();
  }

  @override
  Future<List<TvSeries>> getPopularTvSeries() {
    // TODO: implement getPopularTvSeries
    throw UnimplementedError();
  }

  @override
  Future<List<TvSeries>> getRecommendedTvSeries(int id) {
    // TODO: implement getRecommendedTvSeries
    throw UnimplementedError();
  }

  @override
  Future<List<TvSeries>> getTopRatedTvSeries() {
    // TODO: implement getTopRatedTvSeries
    throw UnimplementedError();
  }

  @override
  Future<List<Season>> getTvSeriesSeasons() {
    // TODO: implement getTvSeriesSeasons
    throw UnimplementedError();
  }

  @override
  Future<List<TvSeries>> searchTvSeries(String data) {
    // TODO: implement searchTvSeries
    throw UnimplementedError();
  }
}
