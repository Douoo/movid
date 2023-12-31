import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/movies/domain/usecases/get_movie_detail.dart';
import 'package:movid/features/movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movid/features/movies/domain/usecases/get_movie_watchlist_status.dart';
import 'package:movid/features/movies/domain/usecases/remove_watchlist.dart';
import 'package:movid/features/movies/domain/usecases/save_watchlist.dart';
import 'package:movid/features/movies/presentation/provider/movie_detail_provider.dart';

import '../../../../helpers/movie/dummy_objects.dart';
import 'movie_detail_provider_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetMovieWatchlistStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockMovieRecommendations;
  late MockGetMovieWatchlistStatus mockWatchlist;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MovieDetailProvider notifier;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockMovieRecommendations = MockGetMovieRecommendations();
    mockWatchlist = MockGetMovieWatchlistStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    notifier = MovieDetailProvider(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockMovieRecommendations,
      getMovieWatchlistStatus: mockWatchlist,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  test(
      'should update the state from loading to loaded when getMovieDetail is successfully executed',
      () async {
    //arrange
    when(mockGetMovieDetail(testId))
        .thenAnswer((realInvocation) async => const Right(testMovieDetail));
    when(mockMovieRecommendations(testId))
        .thenAnswer((realInvocation) async => Right(testMovieList));
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
    when(mockMovieRecommendations(testId))
        .thenAnswer((realInvocation) async => Right(testMovieList));
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
    when(mockMovieRecommendations(testId))
        .thenAnswer((realInvocation) async => const Left(ServerFailure()));
    //act
    await notifier.fetchMovieDetail(testId);
    //assert
    expect(notifier.state, equals(RequestState.error));
  });
}
