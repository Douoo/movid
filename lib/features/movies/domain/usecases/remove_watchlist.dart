import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/movies/domain/entities/movie_detail.dart';
import 'package:movid/features/movies/domain/repositories/movie_repository.dart';

class RemoveWatchlist {
  final MovieRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> call(MovieDetail movie) async {
    return repository.removeWatchlist(movie);
  }
}
