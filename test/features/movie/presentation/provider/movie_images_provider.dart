import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/movies/domain/usecases/get_movie_images.dart';
import 'package:movid/features/movies/presentation/provider/movie_images_provider.dart';

import '../../../../helpers/movie/dummy_objects.dart';
import 'movie_images_provider.mocks.dart';

@GenerateMocks([
  GetMovieImages,
])
void main() {
  late MockGetMovieImages mockGetMovieImages;
  late MovieImagesProvider notifier;

  setUp(() {
    mockGetMovieImages = MockGetMovieImages();
    notifier = MovieImagesProvider(getMovieImages: mockGetMovieImages);
  });

  test(
      'should update the state from loading to loaded when getMovieImages is successfully executed',
      () async {
    //arrange
    when(mockGetMovieImages(testId))
        .thenAnswer((realInvocation) async => const Right(testImage));
    //act
    await notifier.fetchMovieImages(testId);
    //assert
    expect(notifier.state, equals(RequestState.loaded));
  });
  test(
      'should return a MediaImages object when getMovieImages is successfully executed',
      () async {
    //arrange
    when(mockGetMovieImages(testId))
        .thenAnswer((realInvocation) async => const Right(testImage));
    //act
    await notifier.fetchMovieImages(testId);
    //assert
    expect(notifier.state, equals(RequestState.loaded));
    expect(notifier.mediaImages, equals(testImage));
  });
  test(
      'should return a Failure object when getMovieImages is successfully executed',
      () async {
    //arrange
    when(mockGetMovieImages(testId))
        .thenAnswer((realInvocation) async => const Left(ServerFailure()));
    //act
    await notifier.fetchMovieImages(testId);
    //assert
    expect(notifier.state, equals(RequestState.error));
  });
}
