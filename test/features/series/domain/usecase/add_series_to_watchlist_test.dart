import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/series/domain/usecases/add_series_to_watchlist.dart';

import '../../../../helpers/global_test_helpers.mocks.dart';
import '../../../../helpers/series/dummy_objects.dart';

void main() {
  late AddTvsToWatchListUseCase addToWatchListUseCase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    addToWatchListUseCase =
        AddTvsToWatchListUseCase(repository: mockTvRepository);
  });

  test('should add TV tv to watchList in the repository', () async {
    // Arrange
    when(mockTvRepository.addTvToWatchList(testDetailTv))
        .thenAnswer((_) async => const Right(true));

    // Act
    final result = await addToWatchListUseCase.call(testDetailTv);

    // Assert
    expect(result, true);
    verify(mockTvRepository.addTvToWatchList(testDetailTv));
  });
}
