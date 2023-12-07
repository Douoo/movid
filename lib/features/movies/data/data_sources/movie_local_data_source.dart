// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

import 'package:movid/core/errors/exception.dart';
import 'package:movid/features/movies/data/models/movie_model.dart';
import 'package:movid/features/movies/data/models/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<String> saveWatchlist(MovieData movie);
  Future<String> removeWatchlist(MovieData movie);
  Future<bool> hasMovie(int id);
  Future<List<MovieModel>> getWatchlistMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  Box<dynamic> box;

  MovieLocalDataSourceImpl({
    required this.box,
  });

  @override
  Future<List<MovieModel>> getWatchlistMovies() async {
    try {
      final watchlistBox = box;

      List<MovieModel> movies = [];
      for (MovieData movieData in watchlistBox.values) {
        movies.add(MovieModel.copy(movieData));
      }
      return movies;
    } catch (error) {
      throw CacheException();
    }
  }

  @override
  Future<bool> hasMovie(int id) async {
    try {
      final watchlistBox = box;
      final containsMovie = watchlistBox.containsKey(id);
      return containsMovie;
    } catch (error) {
      throw CacheException();
    }
  }

  @override
  Future<String> removeWatchlist(MovieData movie) async {
    try {
      final watchlistBox = box;
      watchlistBox.delete(movie.id);
      return 'Removed from watchlist';
    } catch (error) {
      throw CacheException();
    }
  }

  @override
  Future<String> saveWatchlist(MovieData movie) async {
    try {
      final watchlistBox = box;
      watchlistBox.put(movie.id, movie);
      return 'Added to watchlist';
    } catch (error) {
      throw CacheException();
    }
  }
}
