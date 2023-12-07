import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/movies/domain/repositories/movie_repository.dart';

import '../entities/movie.dart';

class GetWatchlistMovies {
  final MovieRepository repository;

  GetWatchlistMovies(this.repository);
  Future<Either<Failure, List<Movie>>> call() async {
    return repository.getWatchlistMovies();
  }
}
