import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/movies/domain/entities/movie.dart';
import 'package:movid/features/movies/domain/repositories/movie_repository.dart';

class SearchMovie {
  final MovieRepository movieRepository;

  SearchMovie(this.movieRepository);

  Future<Either<Failure, List<Movie>>> call(String query) async {
    return movieRepository.searchMovies(query);
  }
}
