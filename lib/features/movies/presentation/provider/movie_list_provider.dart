import 'package:flutter/foundation.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movid/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:movid/features/movies/domain/usecases/get_top_rated_movies.dart';

import '../../domain/entities/movie.dart';

class MovieListProvider extends ChangeNotifier {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListProvider({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  });

  List<Movie> _nowPlayingMovies = [];

  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  RequestState _nowPlayingState = RequestState.empty;
  RequestState get nowPlayingState => _nowPlayingState;

  List<Movie> _popularMovies = [];
  List<Movie> get popularMovies => _popularMovies;

  RequestState _popularMoviesState = RequestState.empty;
  RequestState get popularMoviesState => _popularMoviesState;

  List<Movie> _topRatedMovies = [];
  List<Movie> get topRatedMovies => _topRatedMovies;

  RequestState _topRatedMoviesState = RequestState.empty;
  RequestState get topRatedMoviesState => _topRatedMoviesState;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingMovies() async {
    _nowPlayingState = RequestState.loading;
    notifyListeners();

    final result = await getNowPlayingMovies();

    result.fold((failure) {
      _message = failure.message;
      _nowPlayingState = RequestState.error;
    }, (movies) {
      _nowPlayingMovies = movies;
      _nowPlayingState = RequestState.loaded;
    });
    notifyListeners();
  }

  Future<void> fetchPopularMovies() async {
    _nowPlayingState = RequestState.loading;
    notifyListeners();

    final result = await getPopularMovies();

    result.fold((failure) {
      _message = failure.message;
      _popularMoviesState = RequestState.error;
    }, (movies) {
      _popularMovies = movies;
      _popularMoviesState = RequestState.loaded;
    });
    notifyListeners();
  }

  Future<void> fetchTopRatedMovies() async {
    _nowPlayingState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedMovies();

    result.fold((failure) {
      _message = failure.message;
      _topRatedMoviesState = RequestState.error;
    }, (movies) {
      _topRatedMovies = movies;
      _topRatedMoviesState = RequestState.loaded;
    });
    notifyListeners();
  }
}
