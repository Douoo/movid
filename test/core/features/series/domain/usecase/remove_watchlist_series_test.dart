import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/usecases/remove_watchlist_series.dart';

import '../../../../../helpers/global_test_helpers.mocks.dart';

void main() {
  late RemoveTvsFromWatchListUseCase removeTvsFromWatchListUseCase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    removeTvsFromWatchListUseCase =
        RemoveTvsFromWatchListUseCase(series: mockTvSeriesRepository);
  });

  const testTvSeries = TvSeries(
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

  test('should remove TV series from watchList in the repository', () async {
    // Arrange
    when(mockTvSeriesRepository.removeWatchListSeries(testTvSeries))
        .thenAnswer((_) async => true);

    // Act
    final result = await removeTvsFromWatchListUseCase.call(testTvSeries);

    // Assert
    expect(result, true);
    verify(mockTvSeriesRepository.removeWatchListSeries(testTvSeries));
  });
}
