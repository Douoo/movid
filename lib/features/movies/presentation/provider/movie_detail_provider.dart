import 'package:flutter/foundation.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/movies/domain/entities/movie.dart';
import 'package:movid/features/movies/domain/entities/movie_detail.dart';
import 'package:movid/features/movies/domain/usecases/get_movie_detail.dart';
import 'package:movid/features/movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movid/features/movies/domain/usecases/get_movie_watchlist_status.dart';
import 'package:movid/features/movies/domain/usecases/remove_watchlist.dart';
import 'package:movid/features/movies/domain/usecases/save_watchlist.dart';

class MovieDetailProvider extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetMovieWatchlistStatus getMovieWatchlistStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailProvider({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getMovieWatchlistStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  RequestState _recommendedMoviesState = RequestState.empty;
  RequestState get recommendedMoviesState => _recommendedMoviesState;

  late MovieDetail _movieDetail;
  MovieDetail get movieDetail => _movieDetail;

  late List<Movie> _recommendedMovies;
  List<Movie> get recommendedMovies => _recommendedMovies;

  bool _isAddedToWatchlist = false;
  bool get isAddedToWatchlist => _isAddedToWatchlist;

  String _message = '';
  String get message => _message;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> fetchMovieDetail(int movieId) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getMovieDetail(movieId);
    final movieRecommendations = await getMovieRecommendations(movieId);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (movieDetail) {
        _recommendedMoviesState = RequestState.loading;
        _movieDetail = movieDetail;
        _state = RequestState.loaded;
        notifyListeners();
        movieRecommendations.fold((failure) {
          _message = failure.message;
          _recommendedMoviesState = RequestState.error;
          notifyListeners();
        }, (movies) {
          _recommendedMoviesState = RequestState.loaded;
          _recommendedMovies = movies;
          notifyListeners();
        });
      },
    );
  }

  Future<void> addToWatchlist(MovieDetail movie) async {
    final result = await saveWatchlist(movie);

    result.fold((failure) {
      _watchlistMessage = failure.message;
    }, (successMsg) {
      _watchlistMessage = successMsg;
    });

    loadWatchlistStatus(movie.id);
    notifyListeners();
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await removeWatchlist(movie);

    result.fold((failure) {
      _watchlistMessage = failure.message;
    }, (successMsg) {
      _watchlistMessage = successMsg;
    });
    loadWatchlistStatus(movie.id);
    notifyListeners();
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getMovieWatchlistStatus(id);
    _isAddedToWatchlist = result;
    notifyListeners();
  }
}
