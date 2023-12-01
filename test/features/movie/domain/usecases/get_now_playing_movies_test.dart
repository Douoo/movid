import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/movies/domain/usecases/get_now_playing_movies.dart';

import '../../../../helpers/movie/dummy_objects.dart';
import '../../../../helpers/movie/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late GetNowPlayingMovies getNowPlayingMovies;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getNowPlayingMovies = GetNowPlayingMovies(mockMovieRepository);
  });

  test('should get the now playing movies from the repository', () async {
    //arrange
    when(mockMovieRepository.getNowPlayingMovies())
        .thenAnswer((_) async => Right(testMovieList));
    //act
    final result = await getNowPlayingMovies();
    //assert
    expect(result, Right(testMovieList));
  });
}
