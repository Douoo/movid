// ignore_for_file: deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/core/errors/exception.dart';
import 'package:movid/features/movies/data/data_sources/movie_local_data_source.dart';
import 'package:movid/features/movies/data/models/movie_model.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../../../helpers/global_test_helpers.mocks.dart';

abstract class HiveInterface {
  Future<Box<T>> openBox<T>(String name);
}

class MockHiveBox extends Mock implements Box {}

void main() {
  late MockHiveInterface mockHive;
  late MockHiveBox mockBox;
  late MovieLocalDataSourceImpl localDataSource;
  const testMockStorage = './test/helpers/fixtures/core';

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    const channel = MethodChannel(
      'plugins.flutter.io/path_provider',
    );
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return testMockStorage;
    });
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    mockHive = MockHiveInterface();
    mockBox = MockHiveBox();
    localDataSource = MovieLocalDataSourceImpl();
  });
  group('getWatchlistMovies', () {
    test('should return a list of MovieModel from Hive', () async {
      // arrange
      when(mockHive.openBox(any)).thenAnswer((_) async => mockBox);

      // act
      final result = await localDataSource.getWatchlistMovies();

      // assert
      expect(result, isA<List<MovieModel>>());
      verify(mockHive.openBox('watchlist')).called(1);
      verify(mockBox.values).called(1);
    });

    test('should throw a CacheException if an error occurs', () async {
      // arrange
      when(mockHive.openBox(any)).thenThrow(CacheException());

      // act
      final call = localDataSource.getWatchlistMovies;

      // assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  // group('hasMovie', () {
  //   test('should return true if the movie exists in Hive', () async {
  //     // Arrange
  //     final mockBox = MockBox();
  //     when(mockHive.openBox(any)).thenAnswer((_) async => mockBox);
  //     when(mockBox.containsKey(any)).thenReturn(true);

  //     // Act
  //     final result = await watchlistLocalDataSource.hasMovie(1);

  //     // Assert
  //     expect(result, true);
  //     verify(mockHive.openBox('watchlist')).called(1);
  //     verify(mockBox.containsKey(1)).called(1);
  //   });

  //   test('should return false if the movie does not exist in Hive', () async {
  //     // Arrange
  //     final mockBox = MockBox();
  //     when(mockHive.openBox(any)).thenAnswer((_) async => mockBox);
  //     when(mockBox.containsKey(any)).thenReturn(false);

  //     // Act
  //     final result = await watchlistLocalDataSource.hasMovie(1);

  //     // Assert
  //     expect(result, false);
  //     verify(mockHive.openBox('watchlist')).called(1);
  //     verify(mockBox.containsKey(1)).called(1);
  //   });

  //   test('should throw a CacheException if an error occurs', () async {
  //     // Arrange
  //     when(mockHive.openBox(any)).thenThrow(Exception());

  //     // Act
  //     final call = watchlistLocalDataSource.hasMovie;

  //     // Assert
  //     expect(() => call(1), throwsA(isA<CacheException>()));
  //   });
  // });

  // group('removeWatchlist', () {
  //   test('should remove the movie from Hive', () async {
  //     // Arrange
  //     final mockBox = MockBox();
  //     when(mockHive.openBox(any)).thenAnswer((_) async => mockBox);

  //     // Act
  //     await watchlistLocalDataSource.removeWatchlist(MovieDetailModel(id: 1, /* other properties */));

  //     // Assert
  //     verify(mockHive.openBox('watchlist')).called(1);
  //     verify(mockBox.delete(1)).called(1);
  //   });

  //   test('should throw a CacheException if an error occurs', () async {
  //     // Arrange
  //     when(mockHive.openBox(any)).thenThrow(Exception());

  //     // Act
  //     final call = watchlistLocalDataSource.removeWatchlist;

  //     // Assert
  //     expect(() => call(MovieDetailModel(id: 1, /* other properties */)), throwsA(isA<CacheException>()));
  //   });
  // });

  // group('saveWatchlist', () {
  //   test('should save the movie to Hive', () async {
  //     // Arrange
  //     final mockBox = MockBox();
  //     when(mockHive.openBox(any)).thenAnswer((_) async => mockBox);

  //     // Act
  //     await watchlistLocalDataSource.saveWatchlist(MovieDetailModel(id: 1, /* other properties */));

  //     // Assert
  //     verify(mockHive.openBox('watchlist')).called(1);
  //     verify(mockBox.put(1, any)).called(1);
  //   });

  //   test('should throw a CacheException if an error occurs', () async {
  //     // Arrange
  //     when(mockHive.openBox(any)).thenThrow(Exception());

  //     // Act
  //     final call = watchlistLocalDataSource.saveWatchlist;

  //     // Assert
  //     expect(() => call(MovieDetailModel(id: 1, /* other properties */)), throwsA(isA<CacheException>()));
  //   });
  // });
}
