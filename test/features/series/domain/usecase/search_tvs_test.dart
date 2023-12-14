import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/usecases/series/search_tvs.dart';

import '../../../../helpers/global_test_helpers.mocks.dart';

void main() {
  late SearchTvsUseCase searchTvsUseCase;
  late MockTvRepository mockTvRepository;
  setUp(() {
    mockTvRepository = MockTvRepository();
    searchTvsUseCase = SearchTvsUseCase(tv: mockTvRepository);
  });

  const testTv = Tv(
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

  test('should get on air tv tv from repository', () async {
    //arrange
    when(mockTvRepository.searchTv(testSearchData, 1))
        .thenAnswer((_) async => const Right([testTv]));
    //act
    final result = await searchTvsUseCase.call(testSearchData, 1);

    // assert
    expect(result, const Right([testTv]));
  });
}
