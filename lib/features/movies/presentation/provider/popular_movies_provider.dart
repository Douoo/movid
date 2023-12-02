import 'package:flutter/foundation.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/movies/domain/entities/movie.dart';
import 'package:movid/features/movies/domain/usecases/get_popular_movies.dart';

class PopularMoviesProvider extends ChangeNotifier {
  final GetPopularMovies getPopularMovies;

  PopularMoviesProvider({required this.getPopularMovies});

  //The following state is for controlling the state of the operation
  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularMovies() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getPopularMovies();

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
