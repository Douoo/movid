import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/search/domain/usecases/search_movie.dart';

import '../../../../helpers/movie/dummy_objects.dart';
import '../../../../helpers/movie/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockRepository;
  late SearchMovie searchMovie;
  setUp(() {
    mockRepository = MockMovieRepository();
    searchMovie = SearchMovie(mockRepository);
  });

  test('should execute the seach movie usecase via the repository', () async {
    when(mockRepository.searchMovies('query'))
        .thenAnswer((_) async => Right(testMovieList));
    //act
    await searchMovie('query');

    //assert
    verify(mockRepository.searchMovies('query'));
  });
}
