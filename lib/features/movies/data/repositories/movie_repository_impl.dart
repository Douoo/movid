import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/exception.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/core/network/network_connection.dart';
import 'package:movid/features/movies/data/data_sources/movie_remote_data_source.dart';
import 'package:movid/features/movies/domain/entities/media_image.dart';
import 'package:movid/features/movies/domain/entities/movie.dart';
import 'package:movid/features/movies/domain/entities/movie_detail.dart';
import 'package:movid/features/movies/domain/repositories/movie_repository.dart';

import '../data_sources/movie_local_data_source.dart';
import '../models/movie_table.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final NetworkConnection networkConnection;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkConnection,
  });

  Future<Either<Failure, T>> _remoteOperation<T>(
      Future<T> Function() operation) async {
    if (await networkConnection.isAvailable) {
      try {
        final result = await operation();
        return Right(result);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, T>> _localOperation<T>(
      Future<T> Function() operation) async {
    try {
      final result = await operation();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id) async {
    return await _remoteOperation(() => remoteDataSource.getMovieDetail(id));
  }

  @override
  Future<Either<Failure, MediaImage>> getMovieImages(int id) async {
    return await _remoteOperation(() => remoteDataSource.getMovieImages(id));
  }

  @override
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id) async {
    return await _remoteOperation(
        () => remoteDataSource.getMovieRecommendations(id));
  }

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    return await _remoteOperation(() => remoteDataSource.getNowPlayingMovies());
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    return await _remoteOperation(() => remoteDataSource.getPopularMovies());
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    return await _remoteOperation(() => remoteDataSource.getTopRatedMovies());
  }

  @override
  Future<Either<Failure, List<Movie>>> getWatchlistMovies() async {
    return await _localOperation(() => localDataSource.getWatchlistMovies());
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    return await localDataSource.hasMovie(id);
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(
      MovieDetail movieDetail) async {
    return await _localOperation(
        () => localDataSource.removeWatchlist(MovieData.copy(movieDetail)));
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movieDetail) async {
    return await _localOperation(
        () => localDataSource.saveWatchlist(MovieData.copy(movieDetail)));
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(String query) async {
    return await _remoteOperation(() => remoteDataSource.searchMovies(query));
  }
}
