import 'package:flutter/foundation.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/movies/domain/entities/movie_detail.dart';
import 'package:movid/features/movies/domain/usecases/get_movie_detail.dart';

class MovieDetailProvider extends ChangeNotifier {
  final GetMovieDetail getMovieDetail;
  RequestState _state = RequestState.empty;

  MovieDetailProvider({required this.getMovieDetail});
  RequestState get state => _state;

  late MovieDetail _movieDetail;
  MovieDetail get movieDetail => _movieDetail;

  String _message = '';
  String get message => _message;

  Future<void> fetchMovieDetail(int movieId) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getMovieDetail(movieId);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (movieDetail) {
        _movieDetail = movieDetail;
        _state = RequestState.loaded;
      },
    );
    notifyListeners();
  }
}
