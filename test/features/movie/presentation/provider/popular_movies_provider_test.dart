import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:movid/features/movies/presentation/provider/popular_movies_provider.dart';

import '../../../../helpers/movie/dummy_objects.dart';
import 'popular_movies_provider_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMoviesProvider notifier;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    notifier = PopularMoviesProvider(getPopularMovies: mockGetPopularMovies);
  });

  test('should change state to loading when usecase is called', () async {
    //arrange
    when(mockGetPopularMovies()).thenAnswer((_) async => Right(testMovieList));
    //act
    await notifier.fetchPopularMovies();
    //assert
    expect(notifier.state, equals(RequestState.loaded));
  });

  test('should populate the list of movies when method call is successful',
      () async {
    //arrange
    when(mockGetPopularMovies()).thenAnswer((_) async => Right(testMovieList));
    //act
    await notifier.fetchPopularMovies();
    //assert
    expect(notifier.state, equals(RequestState.loaded));
    expect(notifier.movies, equals(testMovieList));
  });

  test('should return failure when method call is not successful', () async {
    //arrange
    when(mockGetPopularMovies())
        .thenAnswer((_) async => const Left(ServerFailure()));
    //act
    await notifier.fetchPopularMovies();
    //assert
    expect(notifier.state, equals(RequestState.error));
  });
}
