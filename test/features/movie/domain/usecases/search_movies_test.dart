import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/movies/domain/usecases/search_movies.dart';

import '../../../../helpers/movie/dummy_objects.dart';
import '../../../../helpers/movie/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late SearchMovies searchMovies;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    searchMovies = SearchMovies(mockMovieRepository);
  });

  test('should get the search movies result from the repository', () async {
    //arrange
    when(mockMovieRepository.searchMovies(testMovieQuery))
        .thenAnswer((_) async => Right(testMovieList));
    //act
    final result = await searchMovies(testMovieQuery);
    //assert
    expect(result, Right(testMovieList));
  });
}
