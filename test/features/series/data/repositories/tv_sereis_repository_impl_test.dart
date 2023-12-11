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
  late MockTvSeriesRemoteDataSource mockTvSeriesRemoteDataSource;
  late TvSeriesRepositoryImpl repositoryImpl;

  setUp(() {
    mockConnection = MockNetworkConnection();
    mockTvSeriesRemoteDataSource = MockTvSeriesRemoteDataSource();
    repositoryImpl = TvSeriesRepositoryImpl(
      remoteDataSource: mockTvSeriesRemoteDataSource,
      connection: mockConnection,
    );
  });
  group('Device Online', () {
    setUp(() {
      when(mockConnection.isAvailable).thenAnswer((_) async => true);
    });

    group('Movie Detail', () {
      test(
          'should return TvSeriesDetail object when call to remote data source is successful',
          () async {
        //arrange
        when(mockTvSeriesRemoteDataSource.getDetailTvSeries(testTvSeriesId))
            .thenAnswer((_) async => testDetailTvSeriesModel);
        //act
        final result = await repositoryImpl.getDetailTvSeries(testTvSeriesId);
        //assert
        expect(result, equals(const Right(testDetailTvSeriesModel)));
        verify(mockConnection.isAvailable);
      });
      test(
          'should throw ServerFailure when call to remote data source is not succesfful',
          () async {
        //arrange
        when(mockTvSeriesRemoteDataSource.getDetailTvSeries(testTvSeriesId))
            .thenThrow(ServerException());
        //act
        final result = await repositoryImpl.getDetailTvSeries(testTvSeriesId);
        //assert
        expect(result, equals(const Left(ServerFailure())));
      });
    });
    group('Popular Movie', () {
      test(
          'should return a list of movie object when call to remote data source is succesfful',
          () async {
        //arrange
        when(mockTvSeriesRemoteDataSource.getOnAirTvSeries(3))
            .thenAnswer((_) async => [testOnAirTvSeries]);
        //act
        final result = await repositoryImpl.getOnAirTvSeries(2);
        //assert
        verify(mockConnection.isAvailable);
        expect(result, equals(const Right(testOnAirTvSeries)));
      });
      test(
          'should throw ServerFailure when call to remote data source is not succesfful',
          () async {
        //arrange
        when(mockTvSeriesRemoteDataSource.getPopularTvSeries())
            .thenThrow(ServerException());
        //act
        final result = await repositoryImpl.getPopularTvSeries(1);
        //assert
        expect(result, const Left(ServerFailure()));
      });
    });

    group('Top Rated Movie', () {
      test(
          'should return a list of movie object when call to remote data source is succesfful',
          () async {
        //arrange
        when(mockTvSeriesRemoteDataSource.getTopRatedTvSeries())
            .thenAnswer((_) async => [testTopRatedTvSeries]);
        //act
        final result = await repositoryImpl.getTopRatedTvSeries(1);
        //assert
        verify(mockConnection.isAvailable);
        expect(result, equals(const Right(testTopRatedTvSeries)));
      });
      test(
          'should throw ServerFailure when call to remote data source is not succesfful',
          () async {
        //arrange
        when(mockTvSeriesRemoteDataSource.getTopRatedTvSeries())
            .thenThrow(ServerException());
        //act
        final result = await repositoryImpl.getTopRatedTvSeries(1);
        //assert
        expect(result, const Left(ServerFailure()));
      });
    });
    group('Movie Recommendations', () {
      test('''should return a list of movie object relative to the movie id
           when call to remote data source is succesfful''', () async {
        //arrange
        when(mockTvSeriesRemoteDataSource
                .getRecommendedTvSeries(testTvSeriesId))
            .thenAnswer((_) async => [testRecommendedTvSeries]);
        //act
        final result =
            await repositoryImpl.getRecommendedTvSeries(testTvSeriesId);
        //assert
        verify(mockConnection.isAvailable);
        expect(result, equals(const Right(testRecommendedTvSeries)));
      });
      test(
          'should throw ServerFailure when call to remote data source is not succesfful',
          () async {
        //arrange
        when(mockTvSeriesRemoteDataSource
                .getRecommendedTvSeries(testTvSeriesId))
            .thenThrow(ServerException());
        //act
        final result =
            await repositoryImpl.getRecommendedTvSeries(testTvSeriesId);
        //assert
        expect(result, const Left(ServerFailure()));
      });
    });
    group('Search Movie', () {
      test(
          'should return a list of movie object when call to remote data source is succesfful',
          () async {
        //arrange
        when(mockTvSeriesRemoteDataSource.searchTvSeries(testTvSeriesQuery))
            .thenAnswer((_) async => testTvSeriesList);
        //act
        final result =
            await repositoryImpl.searchTvSeries(testTvSeriesQuery, 1);
        //assert
        verify(mockConnection.isAvailable);
        expect(result, equals(Right(testTvSeriesList)));
      });
      test(
          'should throw ServerFailure when call to remote data source is not succesfful',
          () async {
        //arrange
        when(mockTvSeriesRemoteDataSource.searchTvSeries(testTvSeriesQuery))
            .thenThrow(ServerException());
        //act
        final result =
            await repositoryImpl.searchTvSeries(testTvSeriesQuery, 1);
        //assert
        expect(result, const Left(ServerFailure()));
      });
    });
    group('Media Images', () {
      test(
          'should return a MediaImage object when call to remote data source is succesfful',
          () async {
        //arrange
        when(mockTvSeriesRemoteDataSource.getSeriesImages(testTvSeriesId))
            .thenAnswer((_) async => testImageModel);
        //act
        final result = await repositoryImpl.getSeriesImages(testTvSeriesId);
        //assert
        verify(mockConnection.isAvailable);
        expect(result, equals(const Right(testImageModel)));
      });
      test(
          'should throw ServerFailure when call to remote data source is not succesfful',
          () async {
        //arrange
        when(mockTvSeriesRemoteDataSource.getSeriesImages(testTvSeriesId))
            .thenThrow(ServerException());
        //act
        final result = await repositoryImpl.getSeriesImages(testTvSeriesId);
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
        final result = await repositoryImpl.getDetailTvSeries(testTvSeriesId);
        //assert
        verifyZeroInteractions(mockTvSeriesRemoteDataSource);
        expect(result, const Left(ConnectionFailure()));
      });
    });
    group('Now Playing Movies', () {
      test(
          'should return ConnectionFailure when there is no network connection',
          () async {
        //act
        final result = await repositoryImpl.getOnAirTvSeries(2);
        //assert
        verifyZeroInteractions(mockTvSeriesRemoteDataSource);
        expect(result, const Left(ConnectionFailure()));
      });
    });
    group('Popular Movies', () {
      test(
          'should return ConnectionFailure when there is no network connection',
          () async {
        //act
        final result = await repositoryImpl.getPopularTvSeries(1);
        //assert
        verifyZeroInteractions(mockTvSeriesRemoteDataSource);
        expect(result, const Left(ConnectionFailure()));
      });
    });
    group('Top Rated Movies', () {
      test(
          'should return ConnectionFailure when there is no network connection',
          () async {
        //act
        final result = await repositoryImpl.getTopRatedTvSeries(1);
        //assert
        verifyZeroInteractions(mockTvSeriesRemoteDataSource);
        expect(result, const Left(ConnectionFailure()));
      });
    });
    group('Movie recommendations', () {
      test(
          'should return ConnectionFailure when there is no network connection',
          () async {
        //act
        final result =
            await repositoryImpl.getRecommendedTvSeries(testTvSeriesId);
        //assert
        verifyZeroInteractions(mockTvSeriesRemoteDataSource);
        expect(result, const Left(ConnectionFailure()));
      });
    });
    group('Search Movies', () {
      test(
          'should return ConnectionFailure when there is no network connection',
          () async {
        //act
        final result =
            await repositoryImpl.searchTvSeries(testTvSeriesQuery, 1);
        //assert
        verifyZeroInteractions(mockTvSeriesRemoteDataSource);
        expect(result, const Left(ConnectionFailure()));
      });
    });
    group('Movie Media Image', () {
      test(
          'should return ConnectionFailure when there is no network connection',
          () async {
        //act
        final result = await repositoryImpl.getSeriesImages(testTvSeriesId);
        //assert
        verifyZeroInteractions(mockTvSeriesRemoteDataSource);
        expect(result, const Left(ConnectionFailure()));
      });
    });
  });
}
