import 'package:flutter/foundation.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/movies/domain/usecases/get_top_rated_movies.dart';

import '../../domain/entities/movie.dart';

class TopRatedMoviesProvider extends ChangeNotifier {
  final GetTopRatedMovies getTopRatedMovies;
  //The following state is for controlling the state of the operation
  RequestState _state = RequestState.empty;

  TopRatedMoviesProvider({required this.getTopRatedMovies});
  RequestState get state => _state;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedMovies() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedMovies();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (movies) {
        _movies = movies;
        _state = RequestState.loaded;
      },
    );
    notifyListeners();
  }
}
