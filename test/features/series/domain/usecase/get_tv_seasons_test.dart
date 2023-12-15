import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/series/domain/entites/season_episode.dart';
import 'package:movid/features/series/domain/usecases/series/get_tv_season_episodes.dart';

import '../../../../helpers/global_test_helpers.mocks.dart';
import '../../../../helpers/series/dummy_objects.dart';

void main() {
  late GetTvSeasonEpisodes getTvsSeasonsUseCase;
  late MockTvSeriesRepository mockTvSeriesRepository;
  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    getTvsSeasonsUseCase = GetTvSeasonEpisodes(series: mockTvSeriesRepository);
  });

  const testTvSeriesSeasons = SeasonEpisode(
      id: 1,
      name: 'test',
      overview: "this is a random ass description",
      airDate: "2023/20/3",
      voteAverage: 8.3,
      voteCount: 0,
      runTime: 56,
      episodeNumber: 3);

  test('should get popular tv series from repository', () async {
    //arrange
    when(mockTvSeriesRepository.getTvSeasonEpisodes(testTvSeriesId, 1))
        .thenAnswer((_) async => const Right([testTvSeriesSeasons]));
    //act
    final result = await getTvsSeasonsUseCase.call(testTvSeriesId, 1);

    // assert
    expect(result, const Right(testTvSeriesSeasons));
  });
}
