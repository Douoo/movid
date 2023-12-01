import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/movies/domain/entities/media_image.dart';
import 'package:movid/features/movies/domain/repositories/movie_repository.dart';

class GetMovieImages {
  final MovieRepository repository;

  GetMovieImages(this.repository);

  Future<Either<Failure, MediaImage>> call(int movieId) {
    return repository.getMovieImages(movieId);
  }
}
