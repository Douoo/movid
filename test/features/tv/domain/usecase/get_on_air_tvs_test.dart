import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/tv/domain/entites/series.dart';
import 'package:movid/features/tv/domain/usecases/series/get_on_air_tvs.dart';

import '../../../../helpers/global_test_helpers.mocks.dart';

void main() {
  late GetOnAirTvsUseCase getOnAirTvsUseCase;
  late MockTvRepository mockTvRepository;
  setUp(() {
    mockTvRepository = MockTvRepository();
    getOnAirTvsUseCase = GetOnAirTvsUseCase(tv: mockTvRepository);
  });

  final testTv = Tv(
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

  test('should get on air tv tv from repository', () async {
    //arrange
    when(mockTvRepository.getOnAirTv(3))
        .thenAnswer((_) async => Right([testTv]));
    //act
    final result = await getOnAirTvsUseCase.call(2);

    // assert
    expect(result, [testTv]);
  });
}
