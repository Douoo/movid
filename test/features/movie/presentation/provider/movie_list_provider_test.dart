import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movid/features/movies/presentation/provider/movie_list_provider.dart';

import '../../../../helpers/movie/dummy_objects.dart';
import 'movie_list_provider_test.mocks.dart';
import 'popular_movies_provider_test.mocks.dart';
import 'top_rated_movies_provider_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MovieListProvider notifier;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    notifier = MovieListProvider(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

  group('Now Playing Movies', () {
    test(
        'should change the state from loading to loaded when method is actively loading',
        () async {
      //arrange
      when(mockGetNowPlayingMovies())
          .thenAnswer((_) async => Right(testMovieList));
      //act
      await notifier.fetchNowPlayingMovies();
      //assert
      expect(notifier.nowPlayingState, equals(RequestState.loaded));
    });

    test(
      'should populate nowPlayingMovies list if call to method is successful',
      () async {
        //arrange
        when(mockGetNowPlayingMovies())
            .thenAnswer((_) async => Right(testMovieList));
        //act
        await notifier.fetchNowPlayingMovies();
        //assert
        expect(notifier.nowPlayingState, equals(RequestState.loaded));
        expect(notifier.nowPlayingMovies, equals(testMovieList));
      },
    );
    test(
      'should change the state error if fetchNowPlayingMovies is not executed succesfully',
      () async {
        //arrange
        when(mockGetNowPlayingMovies())
            .thenAnswer((_) async => const Left(ServerFailure()));
        //act
        await notifier.fetchNowPlayingMovies();
        //assert
        expect(notifier.nowPlayingState, equals(RequestState.error));
      },
    );
  });

  group('Popular Movies', () {
    test(
        'should change the state from loading to loaded when method is actively loading',
        () async {
      //arrange
      when(mockGetPopularMovies())
          .thenAnswer((_) async => Right(testMovieList));
      //act
      await notifier.fetchPopularMovies();
      //assert
      expect(notifier.popularMoviesState, equals(RequestState.loaded));
    });

    test(
      'should populate nowPlayingMovies list if call to method is successful',
      () async {
        //arrange
        when(mockGetPopularMovies())
            .thenAnswer((_) async => Right(testMovieList));
        //act
        await notifier.fetchPopularMovies();
        //assert
        expect(notifier.popularMoviesState, equals(RequestState.loaded));
        expect(notifier.popularMovies, equals(testMovieList));
      },
    );
    test(
      'should change the state error if fetchPopularMovies is not executed succesfully',
      () async {
        //arrange
        when(mockGetPopularMovies())
            .thenAnswer((_) async => const Left(ServerFailure()));
        //act
        await notifier.fetchPopularMovies();
        //assert
        expect(notifier.popularMoviesState, equals(RequestState.error));
      },
    );
  });
  group('Top Rated Movies', () {
    test(
        'should change the state from loading to loaded when method is actively loading',
        () async {
      //arrange
      when(mockGetTopRatedMovies())
          .thenAnswer((_) async => Right(testMovieList));
      //act
      await notifier.fetchTopRatedMovies();
      //assert
      expect(notifier.topRatedMoviesState, equals(RequestState.loaded));
    });

    test(
      'should populate nowPlayingMovies list if call to method is successful',
      () async {
        //arrange
        when(mockGetTopRatedMovies())
            .thenAnswer((_) async => Right(testMovieList));
        //act
        await notifier.fetchTopRatedMovies();
        //assert
        expect(notifier.topRatedMoviesState, equals(RequestState.loaded));
        expect(notifier.topRatedMovies, equals(testMovieList));
      },
    );
    test(
      'should change the state error if fetchPopularMovies is not executed succesfully',
      () async {
        //arrange
        when(mockGetTopRatedMovies())
            .thenAnswer((_) async => const Left(ServerFailure()));
        //act
        await notifier.fetchTopRatedMovies();
        //assert
        expect(notifier.topRatedMoviesState, equals(RequestState.error));
      },
    );
  });
}
