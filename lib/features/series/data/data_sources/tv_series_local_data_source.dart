import 'package:hive/hive.dart';
import 'package:movid/core/errors/exception.dart';

import '../model/series_data.dart';
import '../model/tv_series_model.dart';

abstract class TvLocalDataSource {
  Future<List<TvModel>> getWatchListTv();
  Future<bool> addTvToWatchList(TvData tv);
  Future<bool> removeWatchListTv(int id);
  Future<bool> isAddedToWatchList(int id);
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  Future<Box<E>> openWatchlistBox<E>() async {
    return await Hive.openBox('tvWatchList');
  }

  @override
  Future<bool> addTvToWatchList(TvData tv) async {
    try {
      final watchListBox = await openWatchlistBox();
      await watchListBox.put(tv.id, tv);
      return true;
    } catch (error) {
      throw CacheException();
    }
  }

  @override
  Future<List<TvModel>> getWatchListTv() async {
    try {
      final watchListBox = await openWatchlistBox();

      final List<TvModel> tvList =
          watchListBox.values.map((tvData) => TvModel.copy(tvData)).toList();
      return tvList;
    } catch (error) {
      throw CacheException();
    }
  }

  @override
  Future<bool> isAddedToWatchList(int id) async {
    try {
      final watchListBox = await openWatchlistBox();

      return watchListBox.containsKey(id);
    } catch (error) {
      throw CacheException();
    }
  }

  @override
  Future<bool> removeWatchListTv(int id) async {
    try {
      final watchListBox = await openWatchlistBox();

      await watchListBox.delete(id);
      return true;
    } catch (error) {
      throw CacheException();
    }
  }
}
