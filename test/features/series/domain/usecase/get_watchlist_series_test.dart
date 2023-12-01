import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/usecases/get_watchlist_series.dart';
import '../../../../helpers/global_test_helpers.mocks.dart';

void main() {
  late GetWatchListTvsUseCase getWatchListTvsUseCase;
  late MockTvSeriesRepository mockTvSeriesRepository;
  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    getWatchListTvsUseCase =
        GetWatchListTvsUseCase(series: mockTvSeriesRepository);
  });

  const testTvSeries1 = TvSeries(
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

  const testTvSeries2 = TvSeries(
    id: 2,
    title: 'Test Series 2',
    description: "Another random description",
    language: "en",
    isAdult: true,
    date: "2023/20/5",
    rating: 7.5,
    genreIds: [4, 5, 6],
    backdropPath: "/path/to/backdrop2.jpg",
    poster: "/path/to/poster2.jpg",
  );

  test('should get TV series from watchList in the repository', () async {
    //arrange
    when(mockTvSeriesRepository.getWatchListTvSeries())
        .thenAnswer((_) async => [testTvSeries1, testTvSeries2]);
    //act
    final result = await getWatchListTvsUseCase.call();

    // assert
    expect(result, [testTvSeries1, testTvSeries2]);
    verify(mockTvSeriesRepository.getWatchListTvSeries());
  });
}
