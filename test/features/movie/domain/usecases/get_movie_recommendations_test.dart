import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/movies/domain/usecases/get_movie_recommendations.dart';

import '../../../../helpers/movie/dummy_objects.dart';
import '../../../../helpers/movie/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late GetMovieRecommendations getMovieRecommendations;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getMovieRecommendations = GetMovieRecommendations(mockMovieRepository);
  });

  test('should get recommended movie list from the repository', () async {
    //arrange
    when(mockMovieRepository.getMovieRecommendations(testId))
        .thenAnswer((_) async => Right(testMovieList));
    //act
    final result = await getMovieRecommendations(testId);
    //assert
    expect(result, Right(testMovieList));
  });
}
