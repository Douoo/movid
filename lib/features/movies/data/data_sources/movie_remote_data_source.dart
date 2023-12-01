import 'package:movid/core/errors/exception.dart';
import 'package:movid/core/utils/urls.dart';
import 'package:movid/features/movies/data/models/movie_response.dart';

import '../models/media_image_model.dart';
import '../models/movie_detail_model.dart';
import '../models/movie_model.dart';

import 'package:http/http.dart' as http;

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailModel> getMovieDetail(int id);
  Future<List<MovieModel>> getMovieRecommendations(int id);
  Future<MediaImageModel> getMovieImages(int id);
  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  Future<T> _getData<T>(String url, T Function(dynamic) dataMapper) async {
    try {
      final response = await client.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final mappedData = dataMapper(response.body);
        return mappedData;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) {
    return _getData(
      Urls.movieDetail(id),
      (response) => MovieDetailModel.fromJson(response),
    );
  }

  @override
  Future<MediaImageModel> getMovieImages(int id) {
    return _getData(
      Urls.movieImages(id),
      (response) => MediaImageModel.fromJson(response),
    );
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) {
    return _getData(Urls.movieRecommendations(id),
        (response) => MovieResponse.fromJson(response).movieList);
  }

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    return await _getData(Urls.nowPlayingMovies,
        (jsonResponse) => MovieResponse.fromJson(jsonResponse).movieList);
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    return await _getData(Urls.popularMovies,
        (jsonResponse) => MovieResponse.fromJson(jsonResponse).movieList);
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    return await _getData(
      Urls.topRatedMovies,
      (response) => MovieResponse.fromJson(response).movieList,
    );
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) {
    return _getData(
      Urls.searchMovies(query),
      (response) => MovieResponse.fromJson(response).movieList,
    );
  }
}
