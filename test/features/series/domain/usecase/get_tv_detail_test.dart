import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/usecases/series/get_tv_detail.dart';

import '../../../../helpers/global_test_helpers.mocks.dart';
import '../../../../helpers/series/dummy_objects.dart';

void main() {
  late GetDetailTvsUseCase getDetailTvsUseCase;
  late MockTvSeriesRepository mockTvSeriesRepository;
  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    getDetailTvsUseCase = GetDetailTvsUseCase(series: mockTvSeriesRepository);
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
  const testTvSeriesId = 23112;

  test('should get Detail tv series from repository', () async {
    //arrange
    when(mockTvSeriesRepository.getDetailTvSeries(testTvSeriesId))
        .thenAnswer((_) async => const Right(testDetailTvSeries));
    //act
    final result = await getDetailTvsUseCase.call(testTvSeriesId);

    // assert
    expect(result, const Right(testDetailTvSeries));
  });
}
