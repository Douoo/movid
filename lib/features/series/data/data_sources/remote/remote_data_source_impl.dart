import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movid/core/errors/exception.dart';
import 'package:movid/core/utils/urls.dart';
import 'package:movid/features/series/data/model/media_image_model.dart';
import 'package:movid/features/series/data/model/tv_series_model.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeries>> getOnAirTvSeries();
  Future<List<TvSeries>> getPopularTvSeries();
  Future<List<TvSeries>> getTopRatedTvSeries();
  Future<List<SeriesDetail>> getDetailTvSeries(int id);
  Future<List<TvSeries>> getRecommendedTvSeries(int id);
  Future<List<TvSeries>> getTvSeriesSeasons();
  Future<List<TvSeries>> searchTvSeries(String data);
  Future<MediaImageModel> getSeriesImages(int id);

  Future<List<TvSeries>> getWatchListTvSeries();
  Future<bool> addSeriesToWatchList(TvSeries series);
  Future<bool> removeWatchListSeries(TvSeries series);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  final http.Client client;
  const TvSeriesRemoteDataSourceImpl({required this.client});
  @override
  Future<bool> addSeriesToWatchList(TvSeries series) {
    // TODO: implement addSeriesToWatchList
    throw UnimplementedError();
  }

  @override
  Future<List<TvSeries>> getOnAirTvSeries() async {
    try {
      final response = await client.get(
        Uri.parse(Urls.onTheAirTvs),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)['results'];
        return result.map((e) => TvSeriesModel.fromMap(e)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw CacheException();
    }
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
  Future<List<SeriesDetail>> getDetailTvSeries(
    int id,
  ) {
    // series.forEach((series) {

    // });
    // TODO: implement getDetailTvSeries
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
  Future<List<TvSeries>> getTvSeriesSeasons() {
    // TODO: implement getTvSeriesSeasons
    throw UnimplementedError();
  }

  @override
  Future<List<TvSeries>> searchTvSeries(String data) {
    // TODO: implement searchTvSeries
    throw UnimplementedError();
  }

  @override
  Future<MediaImageModel> getSeriesImages(int id) {
    // TODO: implement getSeriesImages
    throw UnimplementedError();
  }
}
