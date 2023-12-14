import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/usecases/series/get_tv_recommendations.dart';

import '../../../../helpers/global_test_helpers.mocks.dart';

void main() {
  late GetRecommendedTvsUseCase getRecommendedTvsUseCase;
  late MockTvRepository mockTvRepository;
  setUp(() {
    mockTvRepository = MockTvRepository();
    getRecommendedTvsUseCase = GetRecommendedTvsUseCase(tv: mockTvRepository);
  });

  const testRecommendedTv = Tv(
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
  const testTvId = 23112;
  test('should get Recommended tv tv from repository', () async {
    //arrange
    when(mockTvRepository.getRecommendedTv(testTvId))
        .thenAnswer((_) async => const Right([testRecommendedTv]));
    //act
    final result = await getRecommendedTvsUseCase.call(testTvId);

    // assert
    expect(result, const Right([testRecommendedTv]));
  });
}
