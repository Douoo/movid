import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/usecases/series/get_popular_tvs.dart';

import '../../../../helpers/global_test_helpers.mocks.dart';

void main() {
  late GetPopularTvsUseCase getPopularTvsUseCase;
  late MockTvSeriesRepository mockTvSeriesRepository;
  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    getPopularTvsUseCase = GetPopularTvsUseCase(series: mockTvSeriesRepository);
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

  test('should get popular tv series from repository', () async {
    //arrange
    when(mockTvSeriesRepository.getPopularTvSeries())
        .thenAnswer((_) async => [testTvSeries]);
    //act
    final result = await getPopularTvsUseCase.call();

    // assert
    expect(result, [testTvSeries]);
  });
}
