import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/movies/domain/usecases/get_movie_images.dart';

import '../../../../helpers/movie/dummy_objects.dart';
import '../../../../helpers/movie/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late GetMovieImages getMovieImages;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getMovieImages = GetMovieImages(mockMovieRepository);
  });

  test('should get movie images from the repository', () async {
    //arrange
    when(mockMovieRepository.getMovieImages(testId))
        .thenAnswer((_) async => const Right(testImage));
    //act
    final result = await getMovieImages(testId);
    //assert
    expect(result, const Right(testImage));
  });
}
