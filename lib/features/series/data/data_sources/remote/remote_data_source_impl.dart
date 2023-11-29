import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movid/core/errors/exception.dart';
import 'package:movid/core/utils/urls.dart';
import 'package:movid/features/series/data/data_sources/remote/remote_data_source.dart';
import 'package:movid/features/series/data/model/series.dart';
import 'package:movid/features/series/domain/entites/series.dart';

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
      http.Response response = await client.get(
        Uri.parse(Urls.onTheAirTvs),
      );
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)['results'];
        return result.map((e) => TvSeriesModel.fromMap(e)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
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
