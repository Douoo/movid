import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/movies/domain/entities/movie.dart';
import 'package:movid/features/movies/domain/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository respository;

  SearchMovies(this.respository);

  Future<Either<Failure, List<Movie>>> call(String query) async {
    return await respository.searchMovies(query);
  }
}
