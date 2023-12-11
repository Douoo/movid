import 'package:flutter_dotenv/flutter_dotenv.dart';

class Urls {
  static final apiKey = 'api_key=${dotenv.env['API_KEY']}';
  static const baseUrl = 'https://api.themoviedb.org/3';

  /// Movies
  static final String nowPlayingMovies = '$baseUrl/movie/now_playing?$apiKey';
  static final String popularMovies = '$baseUrl/movie/popular?$apiKey';
  static final String topRatedMovies = '$baseUrl/movie/top_rated?$apiKey';
  static String movieDetail(int id) => '$baseUrl/movie/$id?$apiKey';
  static String movieRecommendations(int id) =>
      '$baseUrl/movie/$id/recommendations?$apiKey';

  /// Tvs
  static final String onTheAirTvs = '$baseUrl/tv/on_the_air?$apiKey';
  static String popularTvs(int page) =>
      '$baseUrl/tv/popular?$apiKey&page=$page';
  static String topRatedTvs(int page) =>
      '$baseUrl/tv/top_rated?$apiKey&page=$page';
  static String tvDetail(int id) => '$baseUrl/tv/$id?$apiKey';
  static String tvSeasons(int id, int seasonNumber) =>
      '$baseUrl/tv/$id/season/$seasonNumber?$apiKey';
  static String tvRecommendations(int id) =>
      '$baseUrl/tv/$id/recommendations?$apiKey';

  /// Search Movies
  static String searchMovies(String query) =>
      '$baseUrl/search/movie?$apiKey&query=$query';
  static String searchTvs(String query, int page) =>
      '$baseUrl/search/tv?$apiKey&query=$query&page=$page';

  /// Image
  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
  static String imageUrl(String path) => '$baseImageUrl$path';
  static String movieImages(int id) =>
      '$baseUrl/movie/$id/images?$apiKey&language=en-US&include_image_language=en,null';
  static String tvImages(int id) =>
      '$baseUrl/tv/$id/images?$apiKey&language=en-US&include_image_language=en,null';
}
