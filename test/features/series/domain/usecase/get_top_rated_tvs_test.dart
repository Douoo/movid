import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/usecases/series/get_top_rated_tvs.dart';

import '../../../../helpers/global_test_helpers.mocks.dart';

void main() {
  late GetTopRatedTvsUseCase getTopRatedTvsUseCase;
  late MockTvSeriesRepository mockTvSeriesRepository;
  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    getTopRatedTvsUseCase =
        GetTopRatedTvsUseCase(series: mockTvSeriesRepository);
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

  test('should get TopRated tv series from repository', () async {
    //arrange
    when(mockTvSeriesRepository.getTopRatedTvSeries(1))
        .thenAnswer((_) async => const Right([testTvSeries]));
    //act
    final result = await getTopRatedTvsUseCase.call(1);

    // assert
    expect(result, const Right([testTvSeries]));
  });
}
