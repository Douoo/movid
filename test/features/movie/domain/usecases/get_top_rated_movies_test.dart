import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/movies/domain/usecases/get_top_rated_movies.dart';

import '../../../../helpers/movie/dummy_objects.dart';
import '../../../../helpers/movie/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late GetTopRatedMovies getTopRatedMovies;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getTopRatedMovies = GetTopRatedMovies(mockMovieRepository);
  });

  test('should get top rated movies from the repository', () async {
    //arrange
    when(mockMovieRepository.getTopRatedMovies())
        .thenAnswer((_) async => Right(testMovieList));
    //act
    final result = await getTopRatedMovies();
    //assert
    expect(result, Right(testMovieList));
  });
}
