import 'package:hive/hive.dart';
import 'package:movid/core/errors/exception.dart';
import 'package:movid/features/series/data/model/series_data.dart';
import 'package:movid/features/series/data/model/tv_series_model.dart';

abstract class TvSeriesLocalDataSource {
  Future<List<TvSeriesModel>> getWatchListTvSeries();
  Future<bool> addSeriesToWatchList(SeriesData series);
  Future<bool> removeWatchListSeries(int id);
  Future<bool> isAddedToWatchList(int id);
}

class TvSeriesLocalDataSourceImpl implements TvSeriesLocalDataSource {
  final Box<dynamic> watchListBox;

  TvSeriesLocalDataSourceImpl({required this.watchListBox});

  @override
  Future<bool> addSeriesToWatchList(SeriesData series) async {
    try {
      await watchListBox.put(series.id, series);
      return true;
    } catch (error) {
      print(error);
      throw CacheException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getWatchListTvSeries() async {
    try {
      final List<TvSeriesModel> seriesList = watchListBox.values
          .map((seriesData) => TvSeriesModel.copy(seriesData))
          .toList();
      return seriesList;
    } catch (error) {
      print(error);
      throw CacheException();
    }
  }

  @override
  Future<bool> isAddedToWatchList(int id) async {
    try {
      return watchListBox.containsKey(id);
    } catch (error) {
      print(error);
      throw CacheException();
    }
  }

  @override
  Future<bool> removeWatchListSeries(int id) async {
    try {
      await watchListBox.delete(id);
      return true;
    } catch (error) {
      print(error);
      throw CacheException();
    }
  }
}
