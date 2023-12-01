import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/usecases/add_series_to_watchlist.dart';

import '../../../../helpers/global_test_helpers.mocks.dart';

void main() {
  late AddTvsToWatchListUseCase addToWatchListUseCase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    addToWatchListUseCase =
        AddTvsToWatchListUseCase(series: mockTvSeriesRepository);
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

  test('should add TV series to watchList in the repository', () async {
    // Arrange
    when(mockTvSeriesRepository.addSeriesToWatchList(testTvSeries))
        .thenAnswer((_) async => true);

    // Act
    final result = await addToWatchListUseCase.call(testTvSeries);

    // Assert
    expect(result, true);
    verify(mockTvSeriesRepository.addSeriesToWatchList(testTvSeries));
  });
}
