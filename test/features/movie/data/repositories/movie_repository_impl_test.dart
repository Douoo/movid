import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/core/errors/exception.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/movies/data/repositories/movie_repository_impl.dart';

import '../../../../helpers/global_test_helpers.mocks.dart';
import '../../../../helpers/movie/dummy_objects.dart';

void main() {
  late MockNetworkConnection mockConnection;
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;
  late MovieRepositoryImpl repository;

  setUp(() {
    mockConnection = MockNetworkConnection();
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    repository = MovieRepositoryImpl(
        networkConnection: mockConnection,
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource);
  });

  group('Device Online', () {
    setUp(() {
      when(mockConnection.isAvailable).thenAnswer((_) async => true);
    });

    group('Movie Detail', () {
      test(
          'should return MovieDetail object when call to remote data source is succesfful',
          () async {
        //arrange
        when(mockRemoteDataSource.getMovieDetail(testId))
            .thenAnswer((_) async => testMovieDetailModel);
        //act
        final result = await repository.getMovieDetail(testId);
        //assert
        expect(result, equals(const Right(testMovieDetailModel)));
        verify(mockConnection.isAvailable);
      });
      test(
          'should throw ServerFailure when call to remote data source is not succesfful',
          () async {
        //arrange
        when(mockRemoteDataSource.getMovieDetail(testId))
            .thenThrow(ServerException());
        //act
        final result = await repository.getMovieDetail(testId);
        //assert
        expect(result, equals(const Left(ServerFailure())));
      });
    });
    group('Now Playing Movies', () {
      test(
          'should return a list of movie object when call to remote data source is succesfful',
          () async {
        //arrange
        when(mockRemoteDataSource.getNowPlayingMovies())
            .thenAnswer((_) async => testMovieList);
        //act
        final result = await repository.getNowPlayingMovies();
        //assert
        verify(mockConnection.isAvailable);
        expect(result, equals(Right(testMovieList)));
      });
      test(
          'should throw ServerFailure when call to remote data source is not succesfful',
          () async {
        //arrange
        when(mockRemoteDataSource.getPopularMovies())
            .thenThrow(ServerException());
        //act
        final result = await repository.getPopularMovies();
        //assert
        expect(result, const Left(ServerFailure()));
      });
    });
    group('Popular Movie', () {
      test(
          'should return a list of movie object when call to remote data source is succesfful',
          () async {
        //arrange
        when(mockRemoteDataSource.getPopularMovies())
            .thenAnswer((_) async => testMovieList);
        //act
        final result = await repository.getPopularMovies();
        //assert
        verify(mockConnection.isAvailable);
        expect(result, equals(Right(testMovieList)));
      });
      test(
          'should throw ServerFailure when call to remote data source is not succesfful',
          () async {
        //arrange
        when(mockRemoteDataSource.getPopularMovies())
            .thenThrow(ServerException());
        //act
        final result = await repository.getPopularMovies();
        //assert
        expect(result, const Left(ServerFailure()));
      });
    });
    group('Top Rated Movie', () {
      test(
          'should return a list of movie object when call to remote data source is succesfful',
          () async {
        //arrange
        when(mockRemoteDataSource.getTopRatedMovies())
            .thenAnswer((_) async => testMovieList);
        //act
        final result = await repository.getTopRatedMovies();
        //assert
        verify(mockConnection.isAvailable);
        expect(result, equals(Right(testMovieList)));
      });
      test(
          'should throw ServerFailure when call to remote data source is not succesfful',
          () async {
        //arrange
        when(mockRemoteDataSource.getTopRatedMovies())
            .thenThrow(ServerException());
        //act
        final result = await repository.getTopRatedMovies();
        //assert
        expect(result, const Left(ServerFailure()));
      });
    });
    group('Movie Recommendations', () {
      test('''should return a list of movie object relative to the movie id
           when call to remote data source is succesfful''', () async {
        //arrange
        when(mockRemoteDataSource.getMovieRecommendations(testId))
            .thenAnswer((_) async => testMovieList);
        //act
        final result = await repository.getMovieRecommendations(testId);
        //assert
        verify(mockConnection.isAvailable);
        expect(result, equals(Right(testMovieList)));
      });
      test(
          'should throw ServerFailure when call to remote data source is not succesfful',
          () async {
        //arrange
        when(mockRemoteDataSource.getMovieRecommendations(testId))
            .thenThrow(ServerException());
        //act
        final result = await repository.getMovieRecommendations(testId);
        //assert
        expect(result, const Left(ServerFailure()));
      });
    });
    group('Search Movie', () {
      test(
          'should return a list of movie object when call to remote data source is succesfful',
          () async {
        //arrange
        when(mockRemoteDataSource.searchMovies(testMovieQuery))
            .thenAnswer((_) async => testMovieList);
        //act
        final result = await repository.searchMovies(testMovieQuery);
        //assert
        verify(mockConnection.isAvailable);
        expect(result, equals(Right(testMovieList)));
      });
      test(
          'should throw ServerFailure when call to remote data source is not succesfful',
          () async {
        //arrange
        when(mockRemoteDataSource.searchMovies(testMovieQuery))
            .thenThrow(ServerException());
        //act
        final result = await repository.searchMovies(testMovieQuery);
        //assert
        expect(result, const Left(ServerFailure()));
      });
    });
    group('Media Images', () {
      test(
          'should return a MediaImage object when call to remote data source is succesfful',
          () async {
        //arrange
        when(mockRemoteDataSource.getMovieImages(testId))
            .thenAnswer((_) async => testImageModel);
        //act
        final result = await repository.getMovieImages(testId);
        //assert
        verify(mockConnection.isAvailable);
        expect(result, equals(const Right(testImageModel)));
      });
      test(
          'should throw ServerFailure when call to remote data source is not succesfful',
          () async {
        //arrange
        when(mockRemoteDataSource.getMovieImages(testId))
            .thenThrow(ServerException());
        //act
        final result = await repository.getMovieImages(testId);
        //assert
        expect(result, const Left(ServerFailure()));
      });
    });
  });

  group('When device is offline', () {
    setUp(() {
      when(mockConnection.isAvailable).thenAnswer((_) async => false);
    });
    group('Movie Detail', () {
      test(
          'should return ConnectionFailure when there is no network connection',
          () async {
        //act
        final result = await repository.getMovieDetail(testId);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, const Left(ConnectionFailure()));
      });
    });
    group('Now Playing Movies', () {
      test(
          'should return ConnectionFailure when there is no network connection',
          () async {
        //act
        final result = await repository.getNowPlayingMovies();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, const Left(ConnectionFailure()));
      });
    });
    group('Popular Movies', () {
      test(
          'should return ConnectionFailure when there is no network connection',
          () async {
        //act
        final result = await repository.getPopularMovies();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, const Left(ConnectionFailure()));
      });
    });
    group('Top Rated Movies', () {
      test(
          'should return ConnectionFailure when there is no network connection',
          () async {
        //act
        final result = await repository.getTopRatedMovies();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, const Left(ConnectionFailure()));
      });
    });
    group('Movie recommendations', () {
      test(
          'should return ConnectionFailure when there is no network connection',
          () async {
        //act
        final result = await repository.getMovieRecommendations(testId);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, const Left(ConnectionFailure()));
      });
    });
    group('Search Movies', () {
      test(
          'should return ConnectionFailure when there is no network connection',
          () async {
        //act
        final result = await repository.searchMovies(testMovieQuery);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, const Left(ConnectionFailure()));
      });
    });
    group('Movie Media Image', () {
      test(
          'should return ConnectionFailure when there is no network connection',
          () async {
        //act
        final result = await repository.getMovieImages(testId);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, const Left(ConnectionFailure()));
      });
    });
  });
}
