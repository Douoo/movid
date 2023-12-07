import 'package:flutter/material.dart';
import 'package:movid/core/utils/state_enum.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_watchlist_movies.dart';

class MovieWatchlistProvider extends ChangeNotifier {
  final GetWatchlistMovies getWatchlistMovies;

  MovieWatchlistProvider({required this.getWatchlistMovies});

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchlistMovies() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistMovies();

    result.fold((failure) {
      _state = RequestState.error;
      _message = failure.message;
    }, (movies) {
      _movies = movies;
      _state = RequestState.loaded;
    });
    notifyListeners();
  }
}
