import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:movid/core/errors/exception.dart';
import 'package:movid/core/utils/urls.dart';
import 'package:movid/features/series/data/model/media_image_model.dart';
import 'package:movid/features/series/data/model/series_detail_model.dart';
import 'package:movid/features/series/data/model/series_response.dart';
import 'package:movid/features/series/data/model/tv_series_model.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeries>> getOnAirTvSeries(int page);
  Future<List<TvSeries>> getPopularTvSeries();
  Future<List<TvSeries>> getTopRatedTvSeries();
  Future<SeriesDetail> getDetailTvSeries(int id);
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

  Future<T> _getData<T>(String url, T Function(dynamic) dataMapper,
      Map<String, int> queryParams) async {
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return dataMapper(response.body);
      } else {
        log('Failed to load data from $url');
        throw ServerException();
      }
    } catch (e) {
      print(" are wooooooooo $e");

      throw ServerException();
    }
  }

  @override
  Future<List<TvSeries>> getOnAirTvSeries(int page) async {
    return _getData(
        Urls.onTheAirTvs,
        (response) => TvSeriesResponse.fromJson(response).tvList,
        {"page": page});
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
  Future<SeriesDetail> getDetailTvSeries(
    int id,
  ) {
    return _getData(Urls.tvDetail(id), (response) {
      print("bura $response");
      return SeriesDetailModel.fromJson(response);
    }, {"page": 1});
  }

  @override
  Future<List<TvSeries>> getPopularTvSeries() async {
    return _getData(Urls.popularTvs,
        (response) => TvSeriesResponse.fromJson(response).tvList, {"page": 1});
  }

  @override
  Future<List<TvSeries>> getRecommendedTvSeries(int id) {
    // TODO: implement getRecommendedTvSeries
    throw UnimplementedError();
  }

  @override
  Future<List<TvSeries>> getTopRatedTvSeries() async {
    log("this is log");
    try {
      final response = await client.get(
        Uri.parse(Urls.topRatedTvs),
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
      throw ServerException(message: e.toString());
    }
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
  Future<MediaImageModel> getSeriesImages(int id) async {
    return _getData(Urls.tvImages(id), (response) {
      return MediaImageModel.fromJson(response);
    }, {"page": 1});
  }
}
