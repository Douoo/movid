import 'package:http/http.dart' as http;
import 'package:movid/core/errors/exception.dart';
import 'package:movid/core/utils/urls.dart';
import 'package:movid/features/series/data/model/media_image_model.dart';
import 'package:movid/features/series/data/model/series_detail_model.dart';
import 'package:movid/features/series/data/model/series_response.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeries>> getOnAirTvSeries(int page);
  Future<List<TvSeries>> getPopularTvSeries(int page);
  Future<List<TvSeries>> getTopRatedTvSeries(int page);
  Future<SeriesDetail> getDetailTvSeries(int id);
  Future<List<TvSeries>> getRecommendedTvSeries(int id);
  Future<List<TvSeries>> getTvSeriesSeasons();
  Future<List<TvSeries>> searchTvSeries(String data, int page);
  Future<MediaImageModel> getSeriesImages(int id);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  final http.Client client;
  const TvSeriesRemoteDataSourceImpl({required this.client});

  Future<T> _getData<T>(
    String url,
    T Function(dynamic) dataMapper,
  ) async {
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
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeries>> getOnAirTvSeries(int page) async {
    return _getData(
      Urls.onTheAirTvs,
      (response) => TvSeriesResponse.fromJson(response).tvList,
    );
  }

  @override
  Future<SeriesDetail> getDetailTvSeries(
    int id,
  ) async {
    return await _getData(
      Urls.tvDetail(id),
      (response) => SeriesDetailModel.fromJson(response),
    );
  }

  @override
  Future<List<TvSeries>> getPopularTvSeries(int page) async {
    return _getData(
      Urls.popularTvs(page),
      (response) => TvSeriesResponse.fromJson(response).tvList,
    );
  }

  @override
  Future<List<TvSeries>> getRecommendedTvSeries(int id) {
    // TODO: implement getRecommendedTvSeries
    throw UnimplementedError();
  }

  @override
  Future<List<TvSeries>> getTopRatedTvSeries(int page) async {
    return _getData(Urls.topRatedTvs(page),
        (response) => TvSeriesResponse.fromJson(response).tvList);
  }

  @override
  Future<List<TvSeries>> getTvSeriesSeasons() {
    // TODO: implement getTvSeriesSeasons
    throw UnimplementedError();
  }

  @override
  Future<List<TvSeries>> searchTvSeries(String data, int page) {
    // TODO: implement searchTvSeries
    throw UnimplementedError();
  }

  @override
  Future<MediaImageModel> getSeriesImages(int id) async {
    return _getData(
      Urls.tvImages(id),
      (response) {
        return MediaImageModel.fromJson(response);
      },
    );
  }
}
