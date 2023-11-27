import 'dart:convert';

import 'package:http/http.dart';
import 'package:movid/core/utils/urls.dart';
import 'package:movid/features/series/data/data_sources/remote/remote_data_source.dart';
import 'package:movid/features/series/data/model/series.dart';
import 'package:movid/features/series/domain/entites/series.dart';

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  @override
  Future<bool> addSeriesToWatchList(TvSeries series) {
    // TODO: implement addSeriesToWatchList
    throw UnimplementedError();
  }

  @override
  Future<List<TvSeries>> getOnAirTvSeries() async {
    String endpoint = Urls.onTheAirTvs;
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['results'];
      return result.map((e) => TvSeriesModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
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
  Future<List<TvSeries>> getDetailTvSeries(
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
  Future<List<TvSeries>> searchTvSeries() {
    // TODO: implement searchTvSeries
    throw UnimplementedError();
  }
}
