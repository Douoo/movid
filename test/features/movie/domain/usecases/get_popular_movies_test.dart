import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/movies/domain/usecases/get_popular_movies.dart';

import '../../../../helpers/movie/dummy_objects.dart';
import '../../../../helpers/movie/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late GetPopularMovies getNowPlayingMovies;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getNowPlayingMovies = GetPopularMovies(mockMovieRepository);
  });

  test('should get popular movies from the repository', () async {
    //arrange
    when(mockMovieRepository.getPopularMovies())
        .thenAnswer((_) async => Right(testMovieList));
    //act
    final result = await getNowPlayingMovies();
    //assert
    expect(result, Right(testMovieList));
  });
}
