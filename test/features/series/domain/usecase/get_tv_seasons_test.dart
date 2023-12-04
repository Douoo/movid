import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/series/domain/entites/season.dart';
import 'package:movid/features/series/domain/usecases/series/get_tv_seasons.dart';

import '../../../../helpers/global_test_helpers.mocks.dart';

void main() {
  late GetTvsSeasonsUseCase getTvsSeasonsUseCase;
  late MockTvSeriesRepository mockTvSeriesRepository;
  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    getTvsSeasonsUseCase = GetTvsSeasonsUseCase(series: mockTvSeriesRepository);
  });

  const testTvSeriesSeasons = Season(
      id: 1,
      name: 'test',
      description: "this is a random ass description",
      airDate: "2023/20/3",
      voteAverage: 8.3,
      voteCount: 0,
      runTime: 56,
      episodeNumber: 3);

  test('should get popular tv series from repository', () async {
    //arrange
    when(mockTvSeriesRepository.getTvSeriesSeasons())
        .thenAnswer((_) async => Right(testTvSeriesSeasons));
    //act
    final result = await getTvsSeasonsUseCase.call();

    // assert
    expect(result, Right(testTvSeriesSeasons));
  });
}
