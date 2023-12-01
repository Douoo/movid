import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/movies/domain/usecases/get_movie_detail.dart';

import '../../../../helpers/movie/dummy_objects.dart';
import '../../../../helpers/movie/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late GetMovieDetail getMovieDetail;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getMovieDetail = GetMovieDetail(mockMovieRepository);
  });

  test('should get the movie detail from the repository', () async {
    //arrange
    when(mockMovieRepository.getMovieDetail(testId))
        .thenAnswer((_) async => const Right(testMovieDetail));
    //act
    final result = await getMovieDetail(testId);
    //assert
    expect(result, const Right(testMovieDetail));
  });
}
