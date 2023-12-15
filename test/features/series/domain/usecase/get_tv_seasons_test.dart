import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/series/domain/entites/season_episode.dart';
import 'package:movid/features/series/domain/usecases/series/get_tv_season_episodes.dart';

import '../../../../helpers/global_test_helpers.mocks.dart';
import '../../../../helpers/series/dummy_objects.dart';

void main() {
  late GetTvSeasonEpisodes getTvsSeasonsUseCase;
  late MockTvRepository mockTvRepository;
  setUp(() {
    mockTvRepository = MockTvRepository();
    getTvsSeasonsUseCase = GetTvSeasonEpisodes(series: mockTvRepository);
  });

  const testTvSeasons = SeasonEpisode(
      id: 1,
      name: 'test',
      overview: "this is a random ass description",
      airDate: "2023/20/3",
      voteAverage: 8.3,
      voteCount: 0,
      runTime: 56,
      episodeNumber: 3);

  test('should get popular tv tv from repository', () async {
    //arrange
    when(mockTvRepository.getTvSeasonEpisodes(testTvId, 1))
        .thenAnswer((_) async => const Right([testTvSeasons]));
    //act
    final result = await getTvsSeasonsUseCase.call(testTvId, 1);

    // assert
    expect(result, const Right(testOnAirTv));
  });
}
