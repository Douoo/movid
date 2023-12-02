import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movid/features/movies/presentation/provider/top_rated_movies_provider.dart';

import '../../../../helpers/movie/dummy_objects.dart';
import 'top_rated_movies_provider_test.mocks.dart';

@GenerateMocks([
  GetTopRatedMovies,
])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesProvider notifier;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    notifier = TopRatedMoviesProvider(getTopRatedMovies: mockGetTopRatedMovies);
  });

  test('should change the loading state to loaded when data is received',
      () async {
    //arrange
    when(mockGetTopRatedMovies()).thenAnswer((_) async => Right(testMovieList));
    //act
    await notifier.fetchTopRatedMovies();
    //assert
    expect(notifier.state, equals(RequestState.loaded));
  });
  test('should populate the movie list when call to method is successful',
      () async {
    //arrange
    when(mockGetTopRatedMovies()).thenAnswer((_) async => Right(testMovieList));
    //act
    await notifier.fetchTopRatedMovies();
    //assert
    expect(notifier.state, equals(RequestState.loaded));
    expect(notifier.movies, equals(testMovieList));
  });
  test('should return failure when call to method is not successful', () async {
    //arrange
    when(mockGetTopRatedMovies())
        .thenAnswer((_) async => const Left(ServerFailure()));
    //act
    await notifier.fetchTopRatedMovies();
    //assert
    expect(notifier.state, equals(RequestState.error));
    expect(
        notifier.message, equals('Something went wrong while fetching data'));
  });
}
