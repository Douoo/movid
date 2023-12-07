import 'package:flutter/foundation.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/movies/domain/entities/movie.dart';

import '../../domain/usecases/search_movie.dart';

class MovieSearchProvider extends ChangeNotifier {
  final SearchMovie searchMovie;

  MovieSearchProvider({required this.searchMovie});

  RequestState _searchState = RequestState.empty;
  RequestState get searchState => _searchState;

  String _message = '';
  String get message => _message;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  Future<void> searchForMovie(String query) async {
    _searchState = RequestState.loading;
    notifyListeners();

    final result = await searchMovie(query);

    result.fold((failure) {
      _searchState = RequestState.error;
      _message = failure.message;
    }, (movies) {
      _movies = movies;
      _searchState = RequestState.loaded;
    });
    notifyListeners();
  }
}
