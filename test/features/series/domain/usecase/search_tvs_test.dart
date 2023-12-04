import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/usecases/series/search_tvs.dart';

import '../../../../helpers/global_test_helpers.mocks.dart';

void main() {
  late SearchTvsUseCase searchTvsUseCase;
  late MockTvSeriesRepository mockTvSeriesRepository;
  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    searchTvsUseCase = SearchTvsUseCase(series: mockTvSeriesRepository);
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

  const testSearchData = "Happy";

  test('should get on air tv series from repository', () async {
    //arrange
    when(mockTvSeriesRepository.searchTvSeries(testSearchData))
        .thenAnswer((_) async => const Right([testTvSeries]));
    //act
    final result = await searchTvsUseCase.call(testSearchData);

    // assert
    expect(result, const Right([testTvSeries]));
  });
}
