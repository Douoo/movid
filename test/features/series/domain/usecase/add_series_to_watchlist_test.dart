import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/series/domain/usecases/add_series_to_watchlist.dart';

import '../../../../helpers/global_test_helpers.mocks.dart';
import '../../../../helpers/series/dummy_objects.dart';

void main() {
  late AddTvsToWatchListUseCase addToWatchListUseCase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    addToWatchListUseCase =
        AddTvsToWatchListUseCase(series: mockTvSeriesRepository);
  });

  test('should add TV series to watchList in the repository', () async {
    // Arrange
    when(mockTvSeriesRepository.addSeriesToWatchList(testDetailTvSeries))
        .thenAnswer((_) async => const Right(true));

    // Act
    final result = await addToWatchListUseCase.call(testDetailTvSeries);

    // Assert
    expect(result, true);
    verify(mockTvSeriesRepository.addSeriesToWatchList(testDetailTvSeries));
  });
}
