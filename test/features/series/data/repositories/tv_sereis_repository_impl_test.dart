import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/core/errors/exception.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/series/data/repository/series_repository_impl.dart';

import '../../../../helpers/global_test_helpers.mocks.dart';
import '../../../../helpers/series/dummy_objects.dart';

void main() {
  late MockNetworkConnection mockConnection;
  late MockTvRemoteDataSource mockTvRemoteDataSource;
  late TvRepositoryImpl repositoryImpl;
  late MockTvLocalDataSource localDataSource;

  setUp(() {
    mockConnection = MockNetworkConnection();
    mockTvRemoteDataSource = MockTvRemoteDataSource();
    localDataSource = MockTvLocalDataSource();
    repositoryImpl = TvRepositoryImpl(
      localDataSource: localDataSource,
      remoteDataSource: mockTvRemoteDataSource,
      connection: mockConnection,
    );
  });
  group('Device Online', () {
    setUp(() {
      when(mockConnection.isAvailable).thenAnswer((_) async => true);
    });

    group('Movie Detail', () {
      test(
          'should return TvDetail object when call to remote data source is successful',
          () async {
        //arrange
        when(mockTvRemoteDataSource.getDetailTv(testTvId))
            .thenAnswer((_) async => testDetailTvModel);
        //act
        final result = await repositoryImpl.getDetailTv(testTvId);
        //assert
        expect(result, equals(const Right(testDetailTvModel)));
        verify(mockConnection.isAvailable);
      });
      test(
          'should throw ServerFailure when call to remote data source is not succesfful',
          () async {
        //arrange
        when(mockTvRemoteDataSource.getDetailTv(testTvId))
            .thenThrow(ServerException());
        //act
        final result = await repositoryImpl.getDetailTv(testTvId);
        //assert
        expect(result, equals(const Left(ServerFailure())));
      });
    });
    group('Popular Movie', () {
      test(
          'should return a list of movie object when call to remote data source is succesfful',
          () async {
        //arrange
        when(mockTvRemoteDataSource.getOnAirTv(3))
            .thenAnswer((_) async => [testOnAirTv]);
        //act
        final result = await repositoryImpl.getOnAirTv(2);
        //assert
        verify(mockConnection.isAvailable);
        expect(result, equals(Right(testOnAirTv)));
      });
      test(
          'should throw ServerFailure when call to remote data source is not succesfful',
          () async {
        //arrange
        when(mockTvRemoteDataSource.getPopularTv(1))
            .thenThrow(ServerException());
        //act
        final result = await repositoryImpl.getPopularTv(1);
        //assert
        expect(result, const Left(ServerFailure()));
      });
    });

    group('Top Rated Movie', () {
      test(
          'should return a list of movie object when call to remote data source is succesfful',
          () async {
        //arrange
        when(mockTvRemoteDataSource.getTopRatedTv(1))
            .thenAnswer((_) async => [testTopRatedTv]);
        //act
        final result = await repositoryImpl.getTopRatedTv(1);
        //assert
        verify(mockConnection.isAvailable);
        expect(result, equals(Right(testTopRatedTv)));
      });
      test(
          'should throw ServerFailure when call to remote data source is not succesfful',
          () async {
        //arrange
        when(mockTvRemoteDataSource.getTopRatedTv(1))
            .thenThrow(ServerException());
        //act
        final result = await repositoryImpl.getTopRatedTv(1);
        //assert
        expect(result, const Left(ServerFailure()));
      });
    });
    group('Movie Recommendations', () {
      test('''should return a list of movie object relative to the movie id
           when call to remote data source is succesfful''', () async {
        //arrange
        when(mockTvRemoteDataSource.getRecommendedTv(testTvId))
            .thenAnswer((_) async => [testRecommendedTv]);
        //act
        final result = await repositoryImpl.getRecommendedTv(testTvId);
        //assert
        verify(mockConnection.isAvailable);
        expect(result, equals(Right(testRecommendedTv)));
      });
      test(
          'should throw ServerFailure when call to remote data source is not succesfful',
          () async {
        //arrange
        when(mockTvRemoteDataSource.getRecommendedTv(testTvId))
            .thenThrow(ServerException());
        //act
        final result = await repositoryImpl.getRecommendedTv(testTvId);
        //assert
        expect(result, const Left(ServerFailure()));
      });
    });
    group('Search Movie', () {
      test(
          'should return a list of movie object when call to remote data source is succesfful',
          () async {
        //arrange
        when(mockTvRemoteDataSource.searchTv(testTvQuery, 1))
            .thenAnswer((_) async => [testTv]);
        //act
        final result = await repositoryImpl.searchTv(testTvQuery, 1);
        //assert
        verify(mockConnection.isAvailable);
        expect(result, equals(Right(testTv)));
      });
      test(
          'should throw ServerFailure when call to remote data source is not succesfful',
          () async {
        //arrange
        when(mockTvRemoteDataSource.searchTv(testTvQuery, 1))
            .thenThrow(ServerException());
        //act
        final result = await repositoryImpl.searchTv(testTvQuery, 1);
        //assert
        expect(result, const Left(ServerFailure()));
      });
    });
    group('Media Images', () {
      test(
          'should return a MediaImage object when call to remote data source is succesfful',
          () async {
        //arrange
        when(mockTvRemoteDataSource.getTvImages(testTvId))
            .thenAnswer((_) async => testImageModel);
        //act
        final result = await repositoryImpl.getTvImages(testTvId);
        //assert
        verify(mockConnection.isAvailable);
        expect(result, equals(const Right(testImageModel)));
      });
      test(
          'should throw ServerFailure when call to remote data source is not succesfful',
          () async {
        //arrange
        when(mockTvRemoteDataSource.getTvImages(testTvId))
            .thenThrow(ServerException());
        //act
        final result = await repositoryImpl.getTvImages(testTvId);
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
        final result = await repositoryImpl.getDetailTv(testTvId);
        //assert
        verifyZeroInteractions(mockTvRemoteDataSource);
        expect(result, const Left(ConnectionFailure()));
      });
    });
    group('Now Playing Movies', () {
      test(
          'should return ConnectionFailure when there is no network connection',
          () async {
        //act
        final result = await repositoryImpl.getOnAirTv(2);
        //assert
        verifyZeroInteractions(mockTvRemoteDataSource);
        expect(result, const Left(ConnectionFailure()));
      });
    });
    group('Popular Movies', () {
      test(
          'should return ConnectionFailure when there is no network connection',
          () async {
        //act
        final result = await repositoryImpl.getPopularTv(1);
        //assert
        verifyZeroInteractions(mockTvRemoteDataSource);
        expect(result, const Left(ConnectionFailure()));
      });
    });
    group('Top Rated Movies', () {
      test(
          'should return ConnectionFailure when there is no network connection',
          () async {
        //act
        final result = await repositoryImpl.getTopRatedTv(1);
        //assert
        verifyZeroInteractions(mockTvRemoteDataSource);
        expect(result, const Left(ConnectionFailure()));
      });
    });
    group('Movie recommendations', () {
      test(
          'should return ConnectionFailure when there is no network connection',
          () async {
        //act
        final result = await repositoryImpl.getRecommendedTv(testTvId);
        //assert
        verifyZeroInteractions(mockTvRemoteDataSource);
        expect(result, const Left(ConnectionFailure()));
      });
    });
    group('Search Movies', () {
      test(
          'should return ConnectionFailure when there is no network connection',
          () async {
        //act
        final result = await repositoryImpl.searchTv(testTvQuery, 1);
        //assert
        verifyZeroInteractions(mockTvRemoteDataSource);
        expect(result, const Left(ConnectionFailure()));
      });
    });
    group('Movie Media Image', () {
      test(
          'should return ConnectionFailure when there is no network connection',
          () async {
        //act
        final result = await repositoryImpl.getTvImages(testTvId);
        //assert
        verifyZeroInteractions(mockTvRemoteDataSource);
        expect(result, const Left(ConnectionFailure()));
      });
    });
  });
}
