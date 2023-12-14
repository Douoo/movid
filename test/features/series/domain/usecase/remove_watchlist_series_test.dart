import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/series/domain/usecases/remove_watchlist_series.dart';

import '../../../../helpers/global_test_helpers.mocks.dart';
import '../../../../helpers/series/dummy_objects.dart';

void main() {
  late RemoveTvsFromWatchListUseCase removeTvsFromWatchListUseCase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    removeTvsFromWatchListUseCase =
        RemoveTvsFromWatchListUseCase(repository: mockTvRepository);
  });

  test('should remove TV tv from watchList in the repository', () async {
    // Arrange
    when(mockTvRepository.removeWatchListTv(testDetailTv))
        .thenAnswer((_) async => const Right(true));

    // Act
    final result = await removeTvsFromWatchListUseCase.call(testDetailTv);

    // Assert
    expect(result, true);
    verify(mockTvRepository.removeWatchListTv(testDetailTv));
  });
}
