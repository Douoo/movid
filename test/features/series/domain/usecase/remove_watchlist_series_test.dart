import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/series/domain/usecases/remove_watchlist_series.dart';

import '../../../../helpers/global_test_helpers.mocks.dart';
import '../../../../helpers/series/dummy_objects.dart';

void main() {
  late RemoveTvsFromWatchListUseCase removeTvsFromWatchListUseCase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    removeTvsFromWatchListUseCase =
        RemoveTvsFromWatchListUseCase(series: mockTvSeriesRepository);
  });

  test('should remove TV series from watchList in the repository', () async {
    // Arrange
    when(mockTvSeriesRepository.removeWatchListSeries(testDetailTvSeries))
        .thenAnswer((_) async => const Right(true));

    // Act
    final result = await removeTvsFromWatchListUseCase.call(testDetailTvSeries);

    // Assert
    expect(result, true);
    verify(mockTvSeriesRepository.removeWatchListSeries(testDetailTvSeries));
  });
}
