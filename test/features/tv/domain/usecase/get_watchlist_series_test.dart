import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/tv/domain/entites/series.dart';
import 'package:movid/features/tv/domain/usecases/get_watchlist_series.dart';

import '../../../../helpers/global_test_helpers.mocks.dart';

void main() {
  late GetWatchListTvsUseCase getWatchListTvsUseCase;
  late MockTvRepository mockTvRepository;
  setUp(() {
    mockTvRepository = MockTvRepository();
    getWatchListTvsUseCase = GetWatchListTvsUseCase(tv: mockTvRepository);
  });

  const testTv1 = Tv(
    id: 1,
    title: 'test',
    description: "this is a random ass description",
    language: "en",
    isAdult: false,
    date: "2023/20/3",
    rating: 8.3,
    genreIds: [1, 2, 3],
    backdropPath: "/path/to/backdrop.jpg",
    poster: "/path/to/backdrop.jpg",
  );

  const testTv2 = Tv(
    id: 2,
    title: 'Test tv 2',
    description: "Another random description",
    language: "en",
    isAdult: true,
    date: "2023/20/5",
    rating: 7.5,
    genreIds: [4, 5, 6],
    backdropPath: "/path/to/backdrop2.jpg",
    poster: "/path/to/poster2.jpg",
  );

  test('should get TV tv from watchList in the repository', () async {
    //arrange
    when(mockTvRepository.getWatchListTv())
        .thenAnswer((_) async => const Right([testTv1, testTv2]));
    //act
    final result = await getWatchListTvsUseCase.call();

    // assert
    expect(result, const Right([testTv1, testTv2]));
    verify(mockTvRepository.getWatchListTv);
  });
}
