import 'package:movid/features/series/domain/entites/season.dart';
import 'package:movid/features/series/domain/entites/series.dart';

abstract class TvSeriesRepository {
  Future<List<TvSeries>> getOnAirTvSeries();
  Future<List<TvSeries>> getPopularTvSeries();
  Future<List<TvSeries>> getTopRatedTvSeries();
  Future<List<TvSeries>> getDetailTvSeries(int id);
  Future<List<TvSeries>> getRecommendedTvSeries(int id);
  Future<List<Season>> getTvSeriesSeasons();
  Future<List<TvSeries>> searchTvSeries(String data);

  Future<List<TvSeries>> getWatchListTvSeries();
  Future<bool> addSeriesToWatchList(TvSeries series);
  Future<bool> removeWatchListSeries(TvSeries series);
}
