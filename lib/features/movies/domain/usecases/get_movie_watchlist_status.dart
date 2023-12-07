import 'package:movid/features/movies/domain/repositories/movie_repository.dart';

class GetMovieWatchlistStatus {
  final MovieRepository repository;

  GetMovieWatchlistStatus(this.repository);

  Future<bool> call(int movieId) async {
    return repository.isAddedToWatchlist(movieId);
  }
}
