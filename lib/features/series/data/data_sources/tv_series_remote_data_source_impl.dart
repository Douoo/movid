import 'package:http/http.dart' as http;
import 'package:movid/core/errors/exception.dart';
import 'package:movid/core/utils/urls.dart';
import '../model/media_image_model.dart';
import '../model/seasons_response.dart';
import '../model/series_detail_model.dart';
import '../model/series_response.dart';
import '../../domain/entites/season_episode.dart';
import '../../domain/entites/series.dart';
import '../../domain/entites/series_detail.dart';

abstract class TvRemoteDataSource {
  Future<List<Tv>> getOnAirTv(int page);
  Future<List<Tv>> getPopularTv(int page);
  Future<List<Tv>> getTopRatedTv(int page);
  Future<TvDetail> getDetailTv(int id);
  Future<List<Tv>> getRecommendedTv(int id);
  Future<List<SeasonEpisode>> getTvSeasonEpisodes(int id, int seasonNumber);
  Future<List<Tv>> searchTv(String data, int page);
  Future<MediaImageModel> getTvImages(int id);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  final http.Client client;
  const TvRemoteDataSourceImpl({required this.client});

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
  Future<List<Tv>> getOnAirTv(int page) async {
    return _getData(
      Urls.onTheAirTvs,
      (response) => TvResponse.fromJson(response).tvList,
    );
  }

  @override
  Future<TvDetail> getDetailTv(
    int id,
  ) async {
    return await _getData(
      Urls.tvDetail(id),
      (response) => TvDetailModel.fromJson(response),
    );
  }

  @override
  Future<List<Tv>> getPopularTv(int page) async {
    return _getData(
      Urls.popularTvs(page),
      (response) => TvResponse.fromJson(response).tvList,
    );
  }

  @override
  Future<List<Tv>> getRecommendedTv(int id) {
    return _getData(Urls.tvRecommendations(id), (response) {
      return TvResponse.fromJson(response).tvList;
    });
  }

  @override
  Future<List<Tv>> getTopRatedTv(int page) async {
    return _getData(Urls.topRatedTvs(page),
        (response) => TvResponse.fromJson(response).tvList);
  }

  @override
  Future<List<SeasonEpisode>> getTvSeasonEpisodes(int id, int seasonNumber) {
    return _getData(Urls.tvSeasons(id, seasonNumber), (response) {
      return SeasonResponse.fromJson(response).seasonList;
    });
  }

  @override
  Future<List<Tv>> searchTv(String query, int page) async {
    return _getData(Urls.searchTvs(query, page),
        (response) => TvResponse.fromJson(response).tvList);
  }

  @override
  Future<MediaImageModel> getTvImages(int id) async {
    return _getData(
      Urls.tvImages(id),
      (response) {
        return MediaImageModel.fromJson(response);
      },
    );
  }
}
