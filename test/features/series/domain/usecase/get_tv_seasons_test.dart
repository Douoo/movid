import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/series/domain/entites/season.dart';
import 'package:movid/features/series/domain/usecases/series/get_tv_seasons.dart';

import '../../../../helpers/global_test_helpers.mocks.dart';
import '../../../../helpers/series/dummy_objects.dart';

void main() {
  late GetTvsSeasonsUseCase getTvsSeasonsUseCase;
  late MockTvRepository mockTvRepository;
  setUp(() {
    mockTvRepository = MockTvRepository();
    getTvsSeasonsUseCase = GetTvsSeasonsUseCase(tv: mockTvRepository);
  });

  const testTvSeasons = SeasonEpisode(
      id: 1,
      name: 'test',
      description: "this is a random ass description",
      airDate: "2023/20/3",
      voteAverage: 8.3,
      voteCount: 0,
      runTime: 56,
      episodeNumber: 3);

  test('should get popular tv tv from repository', () async {
    //arrange
    when(mockTvRepository.getTvSeasons(testTvId, 1))
        .thenAnswer((_) async => const Right([testTvSeasons]));
    //act
    final result = await getTvsSeasonsUseCase.call(testTvId, 1);

    // assert
    expect(result, const Right(testOnAirTv));
  });
}
