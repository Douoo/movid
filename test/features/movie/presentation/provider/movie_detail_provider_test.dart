import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/movies/domain/usecases/get_movie_detail.dart';
import 'package:movid/features/movies/presentation/provider/movie_detail_provider.dart';

import '../../../../helpers/movie/dummy_objects.dart';
import 'movie_detail_provider_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MovieDetailProvider notifier;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    notifier = MovieDetailProvider(getMovieDetail: mockGetMovieDetail, getMovieRecommendations: null, getMovieWatchlistStatus: null, saveWatchlist: null, removeWatchlist: null);
  });

  test(
      'should update the state from loading to loaded when getMovieDetail is successfully executed',
      () async {
    //arrange
    when(mockGetMovieDetail(testId))
        .thenAnswer((realInvocation) async => const Right(testMovieDetail));
    //act
    await notifier.fetchMovieDetail(testId);
    //assert
    expect(notifier.state, equals(RequestState.loaded));
  });
  test(
      'should get MovieDetail obj when getMovieDetail is successfully executed',
      () async {
    //arrange
    when(mockGetMovieDetail(testId))
        .thenAnswer((realInvocation) async => const Right(testMovieDetail));
    //act
    await notifier.fetchMovieDetail(testId);
    //assert
    expect(notifier.state, equals(RequestState.loaded));
    expect(notifier.movieDetail, equals(testMovieDetail));
  });
  test(
      'should update state to RequestState.error when method call execution is not successful',
      () async {
    //arrange
    when(mockGetMovieDetail(testId))
        .thenAnswer((realInvocation) async => const Left(ServerFailure()));
    //act
    await notifier.fetchMovieDetail(testId);
    //assert
    expect(notifier.state, equals(RequestState.error));
  });
}
